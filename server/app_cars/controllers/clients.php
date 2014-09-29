<?php
class Clients extends CI_Controller {
  public function __construct()
  {
    parent::__construct();
    $this->load->model('client');
    check_session();
  }

  public function index(){
    $this->load->helper(array('form','zmform'));
    $data['itemlist']  = $this->sclass->get_schools();
    $data['itemlist2'] = $this->sclass->get_sclass(0,0);
    
    $data["school_list"]= $this->sclass->school_select_list();
    
    show_view(self::MODULE_NAME."/list",$data); 
  }

  public function view($cid){
      $data['client'] = $this->client->get_item($cid);
      if (empty($data['client'])) show_404();

      $this->load->helper('form');
      $this->load->view('_common/header');
      show_nav(11);
      
      $data['cars'] = $this->client->get_cars($cid);
      $this->load->view('clients/detail', $data);
      
      $this->load->view('_common/footer');	  
  }

  public function edit($cid) {	
      $data['client'] = $this->client->get_item($cid);
      if (empty($data['client'])) show_404();

      $this->load->helper(array('form','zmform'));
    
      $this->load->view('_common/header');
      show_nav(11);
      
      $this->load->view('clients/edit', $data);
      $this->load->view('_common/footer');	  
  }
  
  public function save() {	
	$this->client->save($this->input->post());
	redirect('clients');
  }
  
  public function link() {
	$clientid=$this->input->post("client_id");
	if ($clientid) {
	  $this->client->link($this->input->post());
	  redirect('clients/'.$clientid);
	} else {
	  redirect('clients');
	}
	
  }
  

}