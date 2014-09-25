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
    
    $data["school"] = 0;
    $data["schools"]= $this->sclass->school_list();
    
    show_view("sclasses/list",$data); 
  }

  public function view($id){
    $this->load->helper(array('form','zmform'));

    $data['item'] = $this->sclass->get_sclass(0,$id);    
    if (empty($data['item'])) {
      show_404();
    } else {
      show_view("sclasses/detail",$data); 
    }
  }

  public function member($id) {	
    $this->load->helper(array('form','zmform'));
    $sclass = $this->sclass->get_sclass(0,$id);
    if (empty($sclass)) {
      show_404();
    } else {
      $data["class_id"] =$id;
      $data["class_name"] =$sclass["name"];
      
      $data['itemlist']  = $this->sclass->get_members($id,0);
      $data['itemlist2'] = $this->sclass->get_members($id,1);
      
      show_view("sclasses/member",$data); 
    }
  }
  
  public function edit($id) {	
    $this->load->helper(array('form','zmform'));
    $data['item'] = $this->sclass->get_sclass(0,$id);
    if (empty($data['item'])) {
      show_404();
    } else {
      $data["schools"]= $this->sclass->school_list();
      show_view("sclasses/edit",$data); 
    }
  }
  
  public function edit_member($id) {	
    $this->load->helper(array('form','zmform'));
    $data['item'] = $this->sclass->get_member($id);
    if (empty($data['item'])) {
      show_404();
    } else {
      show_view("sclasses/edit_member",$data); 
    }
  }
  
  public function save($id) {	
    $this->sclass->save($this->input->post(),$id,2);
    redirect('sclasses');
  }

  public function save_school($id) {	
    $this->sclass->save($this->input->post(),$id,0);
    redirect('sclasses');
  }

  public function save_member($id) {
    $this->sclass->save_member($this->input->post(),$id);
    redirect("sclasses/".$id."/member");
  }
  
  public function delete($id) {	
    if ($this->input->server('REQUEST_METHOD')==="DELETE") {
      $this->sclass->remove($id);
      echo "OK";
      return;
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