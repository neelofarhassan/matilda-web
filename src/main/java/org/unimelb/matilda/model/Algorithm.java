package org.unimelb.matilda.model;

import org.springframework.web.multipart.MultipartFile;

public class Algorithm {
private String algorithmName;
//true for maximize, false for minimize
private String optimizationCriteria;
//2 for absolute, 1 for relative
private String performanceCriteria;
private Double performanceThreshold = 0.05;
private MultipartFile performanceFile;
private String performanceMetricLabel;

public String getPerformanceMetricLabel() {
	return performanceMetricLabel;
}
public void setPerformanceMetricLabel(String performanceMetricLabel) {
	this.performanceMetricLabel = performanceMetricLabel;
}
public MultipartFile getPerformanceFile() {
	return performanceFile;
}
public void setPerformanceFile(MultipartFile performanceFile) {
	this.performanceFile = performanceFile;
}
public String getAlgorithmName() {
	return algorithmName;
}
public void setAlgorithmName(String algorithmName) {
	this.algorithmName = algorithmName;
}
public Double getPerformanceThreshold() {
	return performanceThreshold;
}
public void setPerformanceThreshold(Double performanceThreshold) {
	this.performanceThreshold = performanceThreshold;
}
public String getOptimizationCriteria() {
	return optimizationCriteria;
}
public void setOptimizationCriteria(String optimizationCriteria) {
	this.optimizationCriteria = optimizationCriteria;
}
public String getPerformanceCriteria() {
	return performanceCriteria;
}
public void setPerformanceCriteria(String performanceCriteria) {
	this.performanceCriteria = performanceCriteria;
}

}
