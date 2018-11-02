package org.unimelb.matilda.model;

import java.util.ArrayList;
import java.util.List;

public class ALgorithmicFootPrint {
//	library or custom problem
private Problem problem;
private Algorithm algorithm;
private Feature feature;
//private String problemClass;	
//private String problemName;
private String filePath;
private List<String> selectedAlgorithms = new ArrayList<>();
private List<String> selectedFeatures = new ArrayList<>();
//private MultipartFile performanceFile;
//private MultipartFile binaryFile;
//true for maximize, false for minimize
//private Boolean optimizationCriteria = false;;
////2 for absolute, 1 for relative
//private Integer performanceCriteria;
//private Double performanceThreshold;

private Double betaThreshold = 0.5;

public Feature getFeature() {
	return feature;
}
public void setFeature(Feature feature) {
	this.feature = feature;
}
public List<String> getSelectedAlgorithms() {
	return selectedAlgorithms;
}
public void setSelectedAlgorithms(List<String> selectedAlgorithms) {
	this.selectedAlgorithms = selectedAlgorithms;
}
public List<String> getSelectedFeatures() {
	return selectedFeatures;
}
public void setSelectedFeatures(List<String> selectedFeatures) {
	this.selectedFeatures = selectedFeatures;
}
private Boolean diversity = true;
private Double diversityThreshold= 0.01;

private Boolean coorelation = true;;
private Integer correlationThreshold = 5;

private Boolean clustering = true;
private Integer defaultMaximumClusters = 10;
private Double silhouteThreshold = 0.70;
private Integer numberOfTrees = 50;
private Integer maximumIterations = 1000;
private Integer replicates = 100;
private Boolean useParallel = false;

private Integer densityThreshold = 10;
private Double purityThreshold = 0.75;
private Integer lowerDistanceThreshold = 1;
private Integer higherDistanceThreshold = 25;

private Integer attemptsByPBLDR = 10;
private Boolean calculateAnalytics = false;
private Integer stoppingCriteria = 0;
private Integer maxRestartFunEvals = 0;
private Double maxFunEvals = Math.exp(4);
private Boolean parallelEval = false;
private Boolean DispFinal = false;


public Algorithm getAlgorithm() {
	return algorithm;
}
public void setAlgorithm(Algorithm algorithm) {
	this.algorithm = algorithm;
}
public String getFilePath() {
	return filePath;
}
public void setFilePath(String filePath) {
	this.filePath = filePath;
}
public Problem getProblem() {
	return problem;
}
public void setProblem(Problem problem) {
	this.problem = problem;
}
public Double getBetaThreshold() {
	return betaThreshold;
}
public void setBetaThreshold(Double betaThreshold) {
	this.betaThreshold = betaThreshold;
}
public Boolean getDiversity() {
	return diversity;
}
public void setDiversity(Boolean diversity) {
	this.diversity = diversity;
}
public Double getDiversityThreshold() {
	return diversityThreshold;
}
public void setDiversityThreshold(Double diversityThreshold) {
	this.diversityThreshold = diversityThreshold;
}
public Boolean getCoorelation() {
	return coorelation;
}
public void setCoorelation(Boolean coorelation) {
	this.coorelation = coorelation;
}
public Integer getCorrelationThreshold() {
	return correlationThreshold;
}
public void setCorrelationThreshold(Integer correlationThreshold) {
	this.correlationThreshold = correlationThreshold;
}
public Boolean getClustering() {
	return clustering;
}
public void setClustering(Boolean clustering) {
	this.clustering = clustering;
}
public Integer getDefaultMaximumClusters() {
	return defaultMaximumClusters;
}
public void setDefaultMaximumClusters(Integer defaultMaximumClusters) {
	this.defaultMaximumClusters = defaultMaximumClusters;
}
public Double getSilhouteThreshold() {
	return silhouteThreshold;
}
public void setSilhouteThreshold(Double silhouteThreshold) {
	this.silhouteThreshold = silhouteThreshold;
}
public Integer getNumberOfTrees() {
	return numberOfTrees;
}
public void setNumberOfTrees(Integer numberOfTrees) {
	this.numberOfTrees = numberOfTrees;
}
public Integer getMaximumIterations() {
	return maximumIterations;
}
public void setMaximumIterations(Integer maximumIterations) {
	this.maximumIterations = maximumIterations;
}
public Integer getReplicates() {
	return replicates;
}
public void setReplicates(Integer replicates) {
	this.replicates = replicates;
}
public Boolean getUseParallel() {
	return useParallel;
}
public void setUseParallel(Boolean useParallel) {
	this.useParallel = useParallel;
}
public Integer getDensityThreshold() {
	return densityThreshold;
}
public void setDensityThreshold(Integer densityThreshold) {
	this.densityThreshold = densityThreshold;
}
public Double getPurityThreshold() {
	return purityThreshold;
}
public void setPurityThreshold(Double purityThreshold) {
	this.purityThreshold = purityThreshold;
}
public Integer getLowerDistanceThreshold() {
	return lowerDistanceThreshold;
}
public void setLowerDistanceThreshold(Integer lowerDistanceThreshold) {
	this.lowerDistanceThreshold = lowerDistanceThreshold;
}
public Integer getHigherDistanceThreshold() {
	return higherDistanceThreshold;
}
public void setHigherDistanceThreshold(Integer higherDistanceThreshold) {
	this.higherDistanceThreshold = higherDistanceThreshold;
}
public Integer getAttemptsByPBLDR() {
	return attemptsByPBLDR;
}
public void setAttemptsByPBLDR(Integer attemptsByPBLDR) {
	this.attemptsByPBLDR = attemptsByPBLDR;
}
public Boolean getCalculateAnalytics() {
	return calculateAnalytics;
}
public void setCalculateAnalytics(Boolean calculateAnalytics) {
	this.calculateAnalytics = calculateAnalytics;
}
public Integer getStoppingCriteria() {
	return stoppingCriteria;
}
public void setStoppingCriteria(Integer stoppingCriteria) {
	this.stoppingCriteria = stoppingCriteria;
}
public Integer getMaxRestartFunEvals() {
	return maxRestartFunEvals;
}
public void setMaxRestartFunEvals(Integer maxRestartFunEvals) {
	this.maxRestartFunEvals = maxRestartFunEvals;
}
public Double getMaxFunEvals() {
	return maxFunEvals;
}
public void setMaxFunEvals(Double maxFunEvals) {
	this.maxFunEvals = maxFunEvals;
}
public Boolean getParallelEval() {
	return parallelEval;
}
public void setParallelEval(Boolean parallelEval) {
	this.parallelEval = parallelEval;
}
public Boolean getDispFinal() {
	return DispFinal;
}
public void setDispFinal(Boolean dispFinal) {
	DispFinal = dispFinal;
}
}