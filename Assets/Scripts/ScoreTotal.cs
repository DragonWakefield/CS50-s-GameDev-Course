using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScoreTotal : MonoBehaviour {
	public static int score;

	public static bool first = false;




	void Awake() {
		/*
		if (instance == null) {
			score = 0;
			instance = this;
		} else if (instance != this) {
			
		}
		*/
		if (!first) {
			score = 0;
			first = true;
		} else {
			//score += 1;	
		}
	}
	void Start(){

	}

}
