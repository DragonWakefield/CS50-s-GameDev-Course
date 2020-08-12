using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
public class DespawnonFall : MonoBehaviour {
	public GameObject characterController;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		if (characterController.transform.position.y < 0) {
			ScoreTotal.score = 0;
			SceneManager.LoadScene ("Game Over");
		}
	}
}
