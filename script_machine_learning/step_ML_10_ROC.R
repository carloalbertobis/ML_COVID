
# load roc
load(paste0(dir_list[1],"glm_result_roc.Rdata"))
load(paste0(dir_list[2],"rf_result_roc.Rdata"))
load(paste0(dir_list[3],"svm_result_roc_radial.Rdata"))
load(paste0(dir_list[3],"svm_result_roc_linear.Rdata"))
load(paste0(dir_list[4],"nb_result_roc.Rdata"))
load(paste0(dir_list[4],"nb_result_roc2.Rdata"))
load(paste0(dir_list[4],"nb_result_roc3.Rdata"))
load(paste0(dir_list[5],"knn_result_roc.Rdata"))
load(paste0(dir_list[6],"ann_result_roc.Rdata"))
load(paste0(dir_list[7],"glmnet_result_roc.Rdata"))





#optimisim glm
glmProbs_train <- predict(glmFit, newdata = train.data12_i, type = "prob")
AUC_apparent<-roc(train.data12_i$dp12, glmProbs_train$Yes, ci=T)
AUC_apparent<-AUC_apparent$auc
AUC_validated<-roc(test.data12_i$dp12, glmProbs$Yes, ci=T) #0.68 (0.4648-0.8908)
AUC_validated<-AUC_validated$auc
optimisim_glm<-AUC_apparent - AUC_validated


p2<-roc(rfFit$pred$obs,rfFit$pred$Yes,auc = T,
        smooth = F,
        # arguments for ci
        ci=TRUE, ci.alpha=0.9, stratified=FALSE,
        # arguments for plot
        plot=TRUE, auc.polygon=FALSE, grid=TRUE,
        print.auc=TRUE, show.thres=F, percent=TRUE, col="brown4",
        asp = 0, print.thres=F, main = "Random Forest", legacy.axes=T)
rfroc<-ggroc(p2, colour="salmon", size=1.5) + theme(panel.background = element_blank(), panel.border = element_rect(fill=NA, colour="black"), text=element_text(family="Segoe UI Historic", size=12)) + annotate(geom="text", x=40, y=50, label="AUC: 73.2% (67.2%-79.1%)", family="Segoe UI Historic") + ggtitle("Random Forest")

#optimisim rf
rfProbs_train <- predict(rfFit, newdata = train.data12_i, type = "prob")
AUC_apparent<-roc(train.data12_i$dp12, rfProbs_train$Yes, ci=T)
AUC_apparent<-AUC_apparent$auc
AUC_validated<-roc(test.data12_i$dp12, rfProbs$Yes, ci=T) #0.68 (0.4648-0.8908)
AUC_validated<-AUC_validated$auc
optimisim_rf<-AUC_apparent - AUC_validated



p3<-roc(svmFit$pred$obs,svmFit$pred$Yes,auc = T,
        smooth = F,
        # arguments for ci
        ci=TRUE, ci.alpha=0.9, stratified=FALSE,
        # arguments for plot
        plot=TRUE, auc.polygon=FALSE, grid=TRUE,
        print.auc=TRUE, show.thres=F, percent=TRUE, col="brown4",
        asp = 0, print.thres=F, main = "SVM", legacy.axes=T)
svmroc<-ggroc(p3, colour="purple", size=1.5) + theme(panel.background = element_blank(), panel.border = element_rect(fill=NA, colour="black"), text=element_text(family="Segoe UI Historic", size=12)) + annotate(geom="text", x=20, y=25, label="AUC: 46.0% (39.9%-52.2%)", family="Segoe UI Historic")  + ggtitle("Support Vector Machine")

#optimisim svm
svmProbs_train <- predict(svmFit, newdata = train.data12_i, type = "prob")
AUC_apparent<-roc(train.data12_i$dp12, svmProbs_train$Yes, ci=T)
AUC_apparent<-AUC_apparent$auc
AUC_validated<-roc(test.data12_i$dp12, svmProbs$Yes, ci=T) #0.68 (0.4648-0.8908)
AUC_validated<-AUC_validated$auc
optimisim_svm<-AUC_apparent - AUC_validated


p4<-roc(nbFit$pred$obs,nbFit$pred$Yes,auc = T,
        smooth = F,
        # arguments for ci
        ci=TRUE, ci.alpha=0.9, stratified=FALSE,
        # arguments for plot
        plot=TRUE, auc.polygon=FALSE, grid=TRUE,
        print.auc=TRUE, show.thres=F, percent=TRUE, col="brown4",
        asp = 0, print.thres=F, main = "SVM", legacy.axes=T)
nbroc<-ggroc(p4, colour="cornflowerblue", size=1.5) + theme(panel.background = element_blank(), panel.border = element_rect(fill=NA, colour="black"), text=element_text(family="Segoe UI Historic", size=12)) + annotate(geom="text", x=30, y=50, label="AUC: 65.1% (58.7%-71.6%)", family="Segoe UI Historic")  + ggtitle("Naïve Bayes")

#optimisim nb
nbProbs_train <- predict(nbFit, newdata = train.data12_i, type = "prob")
AUC_apparent<-roc(train.data12_i$dp12, nbProbs_train$Yes, ci=T)
AUC_apparent<-AUC_apparent$auc
AUC_validated<-roc(test.data12_i$dp12, nbProbs$Yes, ci=T) #0.68 (0.4648-0.8908)
AUC_validated<-AUC_validated$auc
optimisim_nb<-AUC_apparent - AUC_validated



p5<-roc(knnFit$pred$obs,knnFit$pred$Yes,auc = T,
        smooth = F,
        # arguments for ci
        ci=TRUE, ci.alpha=0.9, stratified=FALSE,
        # arguments for plot
        plot=TRUE, auc.polygon=FALSE, grid=TRUE,
        print.auc=TRUE, show.thres=F, percent=TRUE, col="brown4",
        asp = 0, print.thres=F, main = "SVM", legacy.axes=T)
knnroc<-ggroc(p5, colour="darkgoldenrod2", size=1.5) + theme(panel.background = element_blank(), panel.border = element_rect(fill=NA, colour="black"), text=element_text(family="Segoe UI Historic", size=12)) + annotate(geom="text", x=40, y=50, label="AUC: 69.6% (63.2%-76.1%)", family="Segoe UI Historic")  + ggtitle("K-nearest neighbour")

#optimisim knn
knnProbs_train <- predict(knnFit, newdata = train.data12_i, type = "prob")
AUC_apparent<-roc(train.data12_i$dp12, knnProbs_train$Yes, ci=T)
AUC_apparent<-AUC_apparent$auc
AUC_validated<-roc(test.data12_i$dp12, knnProbs$Yes, ci=T) #0.68 (0.4648-0.8908)
AUC_validated<-AUC_validated$auc
optimisim_knn<-AUC_apparent - AUC_validated



p6<-roc(annFit$pred$obs,annFit$pred$Yes,auc = T,
        smooth = F,
        # arguments for ci
        ci=TRUE, ci.alpha=0.9, stratified=FALSE,
        # arguments for plot
        plot=TRUE, auc.polygon=FALSE, grid=TRUE,
        print.auc=TRUE, show.thres=F, percent=TRUE, col="brown4",
        asp = 0, print.thres=F, main = "SVM", legacy.axes=T)
annroc<-ggroc(p6, colour="hotpink", size=1.5) + theme(panel.background = element_blank(), panel.border = element_rect(fill=NA, colour="black"), text=element_text(family="Segoe UI Historic", size=12)) + annotate(geom="text", x=30, y=30, label="AUC: 52.9% (46.4%-59.4%)", family="Segoe UI Historic")  + ggtitle("Neural Network")

#optimisim ann
annProbs_train <- predict(annFit, newdata = train.data12_i, type = "prob")
AUC_apparent<-roc(train.data12_i$dp12, annProbs_train$Yes, ci=T)
AUC_apparent<-AUC_apparent$auc
AUC_validated<-roc(test.data12_i$dp12, annProbs$Yes, ci=T) #0.68 (0.4648-0.8908)
AUC_validated<-AUC_validated$auc
optimisim_ann<-AUC_apparent - AUC_validated

ggarrange(glmroc, rfroc, svmroc, nbroc, knnroc, annroc, nrow=3, ncol=2)

roc.test(p1, p2)