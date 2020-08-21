using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class toggleGreen : MonoBehaviour {

	public GameObject cylin;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	void OnTriggerEnter(Collider person) {

		cylin.GetComponent<Renderer>().material.color = Color.green;


	}
}
