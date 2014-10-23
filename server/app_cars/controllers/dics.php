<?php
class Dics extends CI_Controller {
  const MODULE_NAME="dics";

  public function __construct()
  {
    parent::__construct();
    $this->load->model('dic');
    check_session();
  }

  public function index(){
	$this->load->helper(array('form',"zmform"));
	
	// 字典列表
	$data['dic_list'] = $this->dic->get_list();
	
	// 字典类型列表
	$data['type_list'] = $this->dic->get_slist(0,0);
	
	show_view(self::MODULE_NAME."/list",$data); 	
  }

  public function save($id) {	
	$this->dic->save($id,$this->input->post());
	redirect(self::MODULE_NAME);
  }
  
  public function delete($id){
	if ($this->input->server('REQUEST_METHOD')==="DELETE") { // AJAX
	  log_message('error', 'ajax delete:'.$id);
	  $this->dic->remove($id);
	  
	  echo "OK";
	  return;
	}
  }
}