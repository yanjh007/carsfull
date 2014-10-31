<?php
class Tests extends CI_Controller {

  public function __construct()
  {
    parent::__construct();
    //$this->load->model('news_model');
  }

  public function index(){
	$this->load->view('tests/index');

  }

  public function save($param){
	$plist=explode(ZM_URL_SPLIT_CHAR,$param);
	
	echo "p1:".$plist[0];
	echo "<br>p2:".$plist[1];
	echo "<br>p3:".$plist[2];
  
  }
  
}