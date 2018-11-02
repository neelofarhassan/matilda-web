package org.unimelb.matilda.model;

import org.springframework.web.multipart.MultipartFile;

public class Feature {
	private String featureName;
	private String featureType;
	private MultipartFile featureFile;
	
	
	public MultipartFile getFeatureFile() {
		return featureFile;
	}
	public void setFeatureFile(MultipartFile featureFile) {
		this.featureFile = featureFile;
	}
	public String getFeatureName() {
		return featureName;
	}
	public void setFeatureName(String featureName) {
		this.featureName = featureName;
	}
	public String getFeatureType() {
		return featureType;
	}
	public void setFeatureType(String featureType) {
		this.featureType = featureType;
	}
}
