using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class sideSide : MonoBehaviour {

	public GameObject sideRec;
	public float maxRight;
	public float maxLeft;
	public bool right = true;
	// Use this for initialization
	void Start () {
		maxRight = 12;
		maxLeft = 3;
	}
	
	// Update is called once per frame
	void Update () {
		if (sideRec.transform.position.x >= maxRight) {
			right = false;
		} else if (sideRec.transform.position.x <= maxLeft) {
			right = true;
		}
		if (right && sideRec.transform.position.x < maxRight) {
			sideRec.transform.Translate (Vector3.right * Time.deltaTime);

		} else if (!right && sideRec.transform.position.x > maxLeft) {
			sideRec.transform.Translate (Vector3.left * Time.deltaTime);
		}

	}
}
