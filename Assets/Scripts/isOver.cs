using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class isOver : MonoBehaviour {
	public GameObject cylin1;
	public GameObject cylin2;
	public GameObject triggerblock;
	public static bool end = false;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	void OnTriggerEnter(Collider person) {

		if (cylin1.GetComponent<Renderer>().material.color == Color.green && cylin2.GetComponent<Renderer>().material.color == Color.green) {

			end = true;
			triggerblock.SetActive (true);
			print (end);
		}


	}
}
