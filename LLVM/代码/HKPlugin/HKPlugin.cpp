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
    class HKMatchCallback: public MatchFinder::MatchCallback{
    private:
        CompilerInstance &CI;
        
        bool isUserSourceCode(const string fileName){
            if (fileName.empty()) return false;
            //非xcode中的源码都认为是用户的
            if (fileName.find("/Applications/Xcode.app/") == 0) return false;
            return true;
        }
        
        //判断是否应该用copy修饰
        bool isShouldUseCopy(const string typeStr){
            if (typeStr.find("NSString") != string::npos ||
                typeStr.find("NSArray") != string::npos ||
                typeStr.find("NSDictionary") != string::npos) {
                return true;
            }
            return false;
        }
        
    public:
        HKMatchCallback(CompilerInstance &CI):CI(CI){}
        
        //真正的回调!!
        void run(const MatchFinder::MatchResult &Result) {
            //通过Result获取到节点.
         const ObjCPropertyDecl * propertyDecl =   Result.Nodes.getNodeAs<ObjCPropertyDecl>("objcPropertyDecl");
            //获取文件名称
                          string fileName = CI.getSourceManager().getFilename(propertyDecl->getSourceRange().getBegin()).str();
            
            //判断节点有值并且是用户文件
            if (propertyDecl && isUserSourceCode(fileName)) {
                //拿到节点的类型!
                string typeStr = propertyDecl->getType().getAsString();
                //拿到节点的描述信息
                ObjCPropertyDecl::PropertyAttributeKind attrKind = propertyDecl->getPropertyAttributes();
                
                //判断应该使用copy但是没有使用copy
                if (isShouldUseCopy(typeStr) && !(attrKind & ObjCPropertyDecl::OBJC_PR_copy)) {
//                    cout<<typeStr<<"应该使用;copy修饰!但是你没有!"<<endl;
                    //诊断引擎
                    DiagnosticsEngine &diag = CI.getDiagnostics();
                    //Report 报告
                    diag.Report(propertyDecl->getBeginLoc(),diag.getCustomDiagID(DiagnosticsEngine::Warning, "%0这个地方推荐使用copy!!"))<<typeStr;
                    
                }
            }
        }
    };
    

    //自定义的HKConsumer
    class HKConsumer: public ASTConsumer{
    private:
        //AST节点的查找过滤器!
        MatchFinder matcher;
        HKMatchCallback callback;
    public:
        
        HKConsumer(CompilerInstance &CI):callback(CI){
            //添加一个MatchFinder去匹配objcPropertyDecl节点
            //回调在HKMatchCallback里面run方法!
            matcher.addMatcher(objcPropertyDecl().bind("objcPropertyDecl"), &callback);
        }
        
        //解析完一个顶级的声明就回调一次!
        bool HandleTopLevelDecl(DeclGroupRef D) {
//            cout<<"正在解析...."<<endl;
            return true;
        }
        
        //整个文件都解析完成的回调!
        void HandleTranslationUnit(ASTContext &Ctx) {
//            cout<<"文件解析完毕!"<<endl;
            matcher.matchAST(Ctx);
        }
        
    };


    
    //继承PluginASTAction 实现我们自定义的Action
    class HKASTAction:public PluginASTAction{
    public:
        bool ParseArgs(const CompilerInstance &CI, const std::vector<std::string> &arg) {
            return true;
        }
        
        unique_ptr<ASTConsumer> CreateASTConsumer(CompilerInstance &CI, StringRef InFile) {
            return unique_ptr<HKConsumer>(new HKConsumer(CI));
        }
        
    };

}
//注册插件
static FrontendPluginRegistry::Add<HKPlugin::HKASTAction> HK("HKPlugin","this is HKPlugin");

