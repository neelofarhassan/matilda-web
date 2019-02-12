package org.unimelb.matilda.util;

import java.io.File;
import java.io.FileWriter;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.unimelb.matilda.model.ALgorithmicFootPrint;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class JSONUtil {
	static final Logger logger = Logger.getLogger(JSONUtil.class);
@SuppressWarnings("unchecked")
public void createConfigurationJSON(String userName, String userDataPath, ALgorithmicFootPrint algorithm, String problemName) {
//	String problemName = algorithm.getProblem().getProblemName();
	JSONObject object = new JSONObject();
	object.put("userName", userName);
	
	JSONObject generalSettingsObject = new JSONObject();
	generalSettingsObject.put("betaThreshold", algorithm.getBetaThreshold());
	generalSettingsObject.put("bound", algorithm.getBound());
	generalSettingsObject.put("normalization", algorithm.getNormalization());
	object.put("generalSettings", generalSettingsObject);
	
	JSONObject problemObject = new JSONObject();
	problemObject.put("isLibraryProblem", algorithm.getProblem().getLibraryProblem());
	problemObject.put("problemName", algorithm.getProblem().getProblemName());
	JSONArray selectedAlgorithms = new JSONArray();
	JSONArray selectedFeatures = new JSONArray();
	
	if(algorithm.getProblem().getLibraryProblem()) {
		for(String selectedAlgorithm:algorithm.getSelectedAlgorithms()) {
			selectedAlgorithms.add(selectedAlgorithm);	
		}
		for(String selectedFeature:algorithm.getSelectedFeatures()) {
			selectedFeatures.add(selectedFeature);
		}
		problemObject.put("selectedAlgorithms", selectedAlgorithms);
		problemObject.put("selectedFeatures", selectedFeatures);
		if(algorithm.getAddNewAlgorithm() != null && algorithm.getAddNewAlgorithm()) {
			problemObject.put("newAlgorithm", true);
			problemObject.put("performanceFilePath", userDataPath + "/" + userName + "/" + problemName + "/performance.csv");
		}
		if(algorithm.getAddNewFeature() != null && algorithm.getAddNewFeature()) {
			problemObject.put("newFeature", true);
			problemObject.put("featuresFilePath", userDataPath + "/" + userName + "/" + problemName + "/features.csv");
		}
	}else{
		problemObject.put("performanceFilePath", userDataPath + "/" + userName + "/" + problemName + "/performance.csv");
		problemObject.put("featuresFilePath", userDataPath + "/" + userName + "/" + problemName + "/features.csv");
	}
	object.put("problem", problemObject);
	
	// Advanced Configuration Parameter
	JSONArray mainArray = new JSONArray();
	//	Performance
	JSONObject performanceObject = new JSONObject();
	performanceObject.put("performanceCriteria", algorithm.getAlgorithm().getOptimizationCriteria());
	performanceObject.put("performanceMeasure", algorithm.getAlgorithm().getPerformanceCriteria());
	performanceObject.put("goodPerformanceThreshold", algorithm.getAlgorithm().getPerformanceThreshold());
	
	//	Diversity
	JSONObject diversityObject = new JSONObject();
	diversityObject.put("diversity", algorithm.getDiversity());
	diversityObject.put("diversityThreshold", algorithm.getDiversityThreshold());
//	mainArray.add(diversityObject);
	object.put("diversity", diversityObject);

//	object.put("diversity", algorithm.getDiversity());
//	object.put("diversityThreshold", algorithm.getDiversityThreshold());
	//	Coorelation
	JSONObject coorelationObject = new JSONObject();
	coorelationObject.put("coorelation", algorithm.getCoorelation());
	coorelationObject.put("correlationThreshold", algorithm.getCorrelationThreshold());
	object.put("coorelation", coorelationObject);
	//	Clustering
	JSONObject clusteringObject = new JSONObject();
	clusteringObject.put("clustering", algorithm.getClustering());
	clusteringObject.put("defaultMaximumClusters", algorithm.getDefaultMaximumClusters());
	clusteringObject.put("silhouteThreshold", algorithm.getSilhouteThreshold());
	clusteringObject.put("numberOfTrees", algorithm.getNumberOfTrees());
	clusteringObject.put("maximumIterations", algorithm.getMaximumIterations());
	clusteringObject.put("replicates", algorithm.getReplicates());
	clusteringObject.put("useParallel", algorithm.getUseParallel());
	object.put("clustering", clusteringObject);
	//	Footprint
	JSONObject footprintObject = new JSONObject();
	footprintObject.put("densityThreshold", algorithm.getDensityThreshold());
	footprintObject.put("purityThreshold", algorithm.getPurityThreshold());
	footprintObject.put("lowerDistanceThreshold", algorithm.getLowerDistanceThreshold());
	footprintObject.put("higherDistanceThreshold", algorithm.getHigherDistanceThreshold());
	object.put("footprint", footprintObject);
	// pbldr
	JSONObject pbldrObject = new JSONObject();
	pbldrObject.put("attemptsByPBLDR", algorithm.getAttemptsByPBLDR());
	pbldrObject.put("calculateAnalytics", algorithm.getCalculateAnalytics());
	pbldrObject.put("stoppingCriteria", algorithm.getStoppingCriteria());
	pbldrObject.put("maxRestartFunEvals", algorithm.getMaxRestartFunEvals());
	pbldrObject.put("maxFunEvals", algorithm.getMaxFunEvals());
	pbldrObject.put("parallelEval", algorithm.getParallelEval());
	pbldrObject.put("DispFinal", algorithm.getDispFinal());
	object.put("pbldr", pbldrObject);
	
//	mainArray.add(diversityObject);
//	mainArray.add(coorelationObject);
//	mainArray.add(clusteringObject);
//	mainArray.add(footprintObject);
//	mainArray.add(pbldrObject);
//	object.putIfAbsent("", value)
	
	try {
		File file = new File(userDataPath + "/" + userName + "/" + problemName + "/configuration.txt");
		if(!file.exists()) {
			file.getParentFile().mkdirs();
		}
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		JsonParser jp = new JsonParser();
		JsonElement je = jp.parse(object.toJSONString());
		String indentedJsonString = gson.toJson(je);
		FileWriter fileWriter = new FileWriter(file);
		fileWriter.write(indentedJsonString);
		fileWriter.flush();
		fileWriter.close();
		
	}catch(Exception e) {
		logger.error(e);
	}
		
}
}
