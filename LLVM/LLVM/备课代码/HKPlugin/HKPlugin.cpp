#include <iostream>
#include "clang/AST/AST.h"
#include "clang/AST/DeclObjC.h"
#include "clang/AST/ASTConsumer.h"
#include "clang/ASTMatchers/ASTMatchers.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/ASTMatchers/ASTMatchFinder.h"
#include "clang/Frontend/FrontendPluginRegistry.h"

using namespace clang;
using namespace std;
using namespace llvm;
using namespace clang::ast_matchers;


namespace HKPlugin {
    class HKMatchCallback: public MatchFinder::MatchCallback {
    private:
        CompilerInstance &CI;
        //判断是否是自己的文件
        bool isUserSourceCode(const string filename) {
            if (filename.empty()) return false;
            
            // 非Xcode中的源码都认为是用户源码
            if (filename.find("/Applications/Xcode.app/") == 0) return false;
            
            return true;
        }
        
        //判断是否应该用copy修饰。
        bool isShouldUseCopy(const string typeStr) {
            if (typeStr.find("NSString") != string::npos ||
                typeStr.find("NSArray") != string::npos ||
                typeStr.find("NSDictionary") != string::npos/*...*/) {
                return true;
            }
            return false;
        }
        
    public:
        
        HKMatchCallback(CompilerInstance &CI):CI(CI){}
        
        void run(const MatchFinder::MatchResult &Result){
            //通过结果获取到节点。
            const ObjCPropertyDecl *propertyDecl = Result.Nodes.getNodeAs<ObjCPropertyDecl>("objcPropertyDecl");
            //获取文件名称
            string filename = CI.getSourceManager().getFilename(propertyDecl->getSourceRange().getBegin()).str();
            
            if (propertyDecl && isUserSourceCode(filename)) {//如果节点有值,并且是用户文件
                //拿到属性的类型
                string typeStr = propertyDecl->getType().getAsString();
                //拿到节点的描述信息
                ObjCPropertyDecl::PropertyAttributeKind attrKind = propertyDecl->getPropertyAttributes();
                
                //判断是不是应该用Copy
                if (isShouldUseCopy(typeStr) && !(attrKind & ObjCPropertyDecl::OBJC_PR_copy)) {
                    cout<<typeStr<<"应该用copy修饰而没用Copy，发出警告！"<<endl;
                    //诊断引擎
                    DiagnosticsEngine &diag = CI.getDiagnostics();
                    //Report 报告
                    diag.Report(propertyDecl->getBeginLoc(),diag.getCustomDiagID(DiagnosticsEngine::Warning, "%0这个地方推荐用Copy"))<<typeStr;
                }
            }
        }
    };
    
    
    
    
    
    
    
    //自定义的HKConsumer
    class HKConsumer: public ASTConsumer {
    private:
        MatchFinder matcher;
        HKMatchCallback callback;
    public:
        HKConsumer(CompilerInstance &CI):callback(CI){
            
            //添加一个MatchFinder去匹objcPropertyDecl节点
            //回调在HKMatchCallback的run方法里面。
            matcher.addMatcher(objcPropertyDecl().bind("objcPropertyDecl"),&callback);
        }

        // 在整个文件都解析完后被调用
        void HandleTranslationUnit(ASTContext &context) {
            cout<<"解析完毕了！"<<endl;
            matcher.matchAST(context);
        }
    };
   
    //继承PluginASTAction实现我们自定义的 Action
    class HKASTAction: public PluginASTAction {
    public:
        bool ParseArgs(const CompilerInstance &CI,const vector<string> &arg){
            return true;
        }
        
        unique_ptr <ASTConsumer> CreateASTConsumer(CompilerInstance &CI, StringRef InFile) {
            return unique_ptr <HKConsumer> (new HKConsumer(CI));
        }
        
    };
    
}
//注册插件
static FrontendPluginRegistry::Add<HKPlugin::HKASTAction> X("HKPlugin", "This is the description of the plugin");
