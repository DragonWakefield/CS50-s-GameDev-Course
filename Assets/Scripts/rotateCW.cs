using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class rotateCW : MonoBehaviour {
	public GameObject cylinder;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame

	void Update () {
		transform.Rotate(Vector3.up, 100 * Time.deltaTime);
		/*
		x += Time.deltaTime * 10;
		transform.rotation = Quaternion.Euler(180,-90,-90);
		*/
	}
}
