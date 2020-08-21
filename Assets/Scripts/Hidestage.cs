using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Hidestage : MonoBehaviour {
	public GameObject stage;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	void OnTriggerEnter(Collider person) {


		stage.SetActive (false);

	}
}
