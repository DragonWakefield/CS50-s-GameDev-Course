using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class rotateY : MonoBehaviour {
	public GameObject trap6cylin;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		transform.Rotate(Vector3.forward, 50 * Time.deltaTime);
		/*
		x += Time.deltaTime * 10;
		transform.rotation = Quaternion.Euler(180,-90,-90);
		*/
	}
}
