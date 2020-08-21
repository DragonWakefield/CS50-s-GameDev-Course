using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class movingCube : MonoBehaviour {
	public GameObject cube;
	public float maxheight;
	public bool up = false;

	// Use this for initialization
	void Start () {
		maxheight = (float)cube.transform.position.y +  (float)50;
	}

	// Update is called once per frame
	void Update () {
		if (up && cube.transform.position.y < maxheight)  {

			cube.transform.Translate (Vector3.up * Time.deltaTime, Space.World);

		}
	}
	void OnTriggerEnter(Collider person) {


		up = true;

	}
}
