package org.unimelb.matilda.model;

import java.util.List;

public class Problem {
	private Boolean libraryProblem;
	private String problemType;
	private String problemName;
	private String problemCode;
	private List<Algorithm> libraryAlgorithms;
	private List<Feature> features;
	
	
	public String getProblemCode() {
		return problemCode;
	}
	public void setProblemCode(String problemCode) {
		this.problemCode = problemCode;
	}
	public List<Feature> getFeatures() {
		return features;
	}
	public void setFeatures(List<Feature> features) {
		this.features = features;
	}
	public Boolean getLibraryProblem() {
		return libraryProblem;
	}
	public void setLibraryProblem(Boolean libraryProblem) {
		this.libraryProblem = libraryProblem;
	}
	public String getProblemType() {
		return problemType;
	}
	public void setProblemType(String problemType) {
		this.problemType = problemType;
	}
	public String getProblemName() {
		return problemName;
	}
	public void setProblemName(String problemName) {
		this.problemName = problemName;
	}
	public List<Algorithm> getLibraryAlgorithms() {
		return libraryAlgorithms;
	}
	public void setLibraryAlgorithms(List<Algorithm> libraryAlgorithms) {
		this.libraryAlgorithms = libraryAlgorithms;
	}

}
