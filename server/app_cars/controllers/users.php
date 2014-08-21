<?php
class Users extends CI_Controller {

  public function __construct()
  {
    parent::__construct();
    $this->load->model('user');
    check_session();
  }

  public function index(){
	$this->load->helper('form');

	if ($this->input->get("search")) {
	  $keyword=$this->input->get("search");
	  $data['users'] = $this->user->search($keyword);
	} else {
	  $data['users'] = $this->user->search();
	}

    $this->load->view('_common/header');
    
    show_nav(11);

	$data['rolelist'] = $this->user->role_names();
	
    $this->load->view('users/list', $data);

    $this->load->view('_common/footer');
  }

  public function view($cid){
	if ($this->input->server('REQUEST_METHOD')==="DELETE") {
	  $this->user->remove($cid);
	  echo "OK";
	  return;
	}
	
	if ($this->input->get("method") === "delete") {
	  	$this->user->remove($cid);
		redirect('users'); 		  
	} else { //详情页面 基本信息 车辆信息
	  $data['user'] = $this->user->get_user($cid);
	  if (empty($data['user'])) show_404();

	  $this->load->helper('form');
	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  $data['cars'] = $this->user->get_cars($cid);
	  $this->load->view('users/detail', $data);
	  
	  $this->load->view('_common/footer');	  
	}
  }

  public function edit($id) {	
	  $data['user'] = $this->user->get_one($id);
	  if (empty($data['user'])) show_404();

	  $this->load->helper(array('form','zmform'));
	
	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  // 店铺信息
	  $this->load->model('shop');
	  $list=$this->shop->select_list();
	  
	  $list2=array();
	  $select=0;
	  
	  for ($i=0;$i<count($list);$i++) {
		$list2[$i]=$list[$i]["id"].":".$list[$i]["scode"]."-".$list[$i]["name"];
	  }
	  
	  $data["shops"]=$list2;
	  $data["shop_select"]=$select;
	  
	  // 角色信息
	  $data["roles"]=$this->user->role_list();
	  
	  $this->load->view('users/edit', $data);
	  $this->load->view('_common/footer');	  
  }
  
  public function save() {	
	$this->user->save($this->input->post());
	redirect('users');
  }
  
  public function link() {
	$userid=$this->input->post("user_id");
	if ($userid) {
	  $this->user->link($this->input->post());
	  redirect('users/'.$userid);
	} else {
	  redirect('users');
	}	
  }   
}