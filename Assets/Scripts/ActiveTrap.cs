using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class ActiveTrap : MonoBehaviour {

	public CharacterController character;
	public GameObject block;
	public GameObject triggerblock;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		

	}
	void OnTriggerEnter(Collider person) {

		triggerblock.SetActive (true);
		print (2);
	}

}
