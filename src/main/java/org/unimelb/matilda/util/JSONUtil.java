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
import com.google.gson.JsonParser;

public class JSONUtil {
	static final Logger logger = Logger.getLogger(JSONUtil.class);
@SuppressWarnings("unchecked")
public void createConfigurationJSON(String userName, String userDataPath, ALgorithmicFootPrint algorithm) {
	String problemName = algorithm.getProblem().getProblemName();
	JSONObject object = new JSONObject();
	object.put("userName", userName);
	object.put("isLibraryProblem", algorithm.getProblem().getLibraryProblem());
	object.put("problemName", algorithm.getProblem().getProblemName());
	
	JSONArray selectedAlgorithms = new JSONArray();
	JSONArray selectedFeatures = new JSONArray();
	
	if(algorithm.getProblem().getLibraryProblem()) {
		for(String selectedAlgorithm:algorithm.getSelectedAlgorithms()) {
			selectedAlgorithms.add(selectedAlgorithm);	
		}
		for(String selectedFeature:algorithm.getSelectedFeatures()) {
			selectedFeatures.add(selectedFeature);
		}
		object.put("selectedAlgorithms", selectedAlgorithms);
		object.put("selectedFeatures", selectedFeatures);
		if(algorithm.getAddNewAlgorithm() != null && algorithm.getAddNewAlgorithm()) {
			object.put("newAlgorithm", true);
			object.put("performanceFilePath", userDataPath + "/" + userName + "/" + problemName + "/performance.csv");
		}
		if(algorithm.getAddNewFeature() != null && algorithm.getAddNewFeature()) {
			object.put("newFeature", true);
			object.put("featuresFilePath", userDataPath + "/" + userName + "/" + problemName + "/features.csv");
		}
	}else{
		object.put("performanceFilePath", userDataPath + "/" + userName + "/" + problemName + "/performance.csv");
		object.put("featuresFilePath", userDataPath + "/" + userName + "/" + problemName + "/features.csv");
	}
	//Advanced Configuration Parameter
	object.put("diversity", algorithm.getDiversity());
	object.put("diversityThreshold", algorithm.getDiversityThreshold());
	object.put("coorelation", algorithm.getCoorelation());
	object.put("correlationThreshold", algorithm.getCorrelationThreshold());
	object.put("clustering", algorithm.getClustering());
	object.put("defaultMaximumClusters", algorithm.getDefaultMaximumClusters());
	object.put("silhouteThreshold", algorithm.getSilhouteThreshold());
	object.put("numberOfTrees", algorithm.getNumberOfTrees());
	object.put("maximumIterations", algorithm.getMaximumIterations());
	object.put("replicates", algorithm.getReplicates());
	object.put("useParallel", algorithm.getUseParallel());
	object.put("densityThreshold", algorithm.getDensityThreshold());
	object.put("purityThreshold", algorithm.getPurityThreshold());
	object.put("lowerDistanceThreshold", algorithm.getLowerDistanceThreshold());
	object.put("higherDistanceThreshold", algorithm.getHigherDistanceThreshold());
	object.put("attemptsByPBLDR", algorithm.getAttemptsByPBLDR());
	object.put("calculateAnalytics", algorithm.getCalculateAnalytics());
	object.put("stoppingCriteria", algorithm.getStoppingCriteria());
	object.put("maxRestartFunEvals", algorithm.getMaxRestartFunEvals());
	object.put("maxFunEvals", algorithm.getMaxFunEvals());
	object.put("parallelEval", algorithm.getParallelEval());
	object.put("DispFinal", algorithm.getDispFinal());

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
