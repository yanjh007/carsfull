<?php
class Sclasses extends CI_Controller {
  public function __construct() {
    parent::__construct();
    $this->load->model('sclass');
    check_session();
  }

  public function index(){
    $this->load->helper(array('form','zmform'));
    $data['itemlist']  = $this->sclass->get_schools();
    $data['itemlist2'] = $this->sclass->get_sclass(0,0);
    
    $list2=array();
    $select=0;
    $i=0;
    foreach ($data["itemlist"] as $item) {
	  $list2[$i]= $item["id"].":".$item["scode"]."-".$item["name"];
	  $i++;
    }
    
    $data["schools"]= $list2;
    $data["school"] = 0;
    
    show_view("sclasses/list",$data); 
  }

  public function view($id){
    $data['item'] = $this->sclass->get_sclass($id);
    if (empty($data['sclass'])) show_404();

    $this->load->helper('form');
    $this->load->view('_common/header');
    show_nav(11);
    
    $this->load->view('sclasses/detail', $data);
    
    $this->load->view('_common/footer');	  
  }

  public function save_school($id) {	
    $this->sclass->save($this->input->post(),$id,0);
    redirect('sclasses');
  }
  
  public function save($id) {	
    $this->sclass->save($this->input->post(),$id,2);
    redirect('sclasses');
  }
  
  public function delete($id) {	
    if ($this->input->server('REQUEST_METHOD')==="DELETE") {
      $this->sclass->remove($id);
      echo "OK";
      return;
    }
  }
  
  public function edit($id) {	
    $this->load->helper(array('form','zmform'));
    $data['item'] = $this->sclass->get_sclass(0,$id);
    if (empty($data['item'])) {
      show_404();
    } else {
      show_view("sclasses/edit",$data); 
    }
  }
  
  public function link() {
	$sclassid=$this->input->post("sclass_id");
	if ($sclassid) {
	  $this->sclass->link($this->input->post());
	  redirect('sclasss/'.$sclassid);
	} else {
	  redirect('sclasss');
	}	
  }  

}