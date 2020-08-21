using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Hide : MonoBehaviour {
	
	public static bool visibility;
	public GameObject trapCube;
	// Use this for initialization
	void Start () {
		visibility = false;
		trapCube.SetActive (false);
	}

	// Update is called once per frame
	void Update () {
		/*
		if (visibility) {
			trapCube.SetActive (true);

		} else {
			trapCube.SetActive (false);
		}
*/
		
	}
}
