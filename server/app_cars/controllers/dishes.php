<?php
class Dishes extends CI_Controller {

  public function __construct()
  {
    parent::__construct();
    $this->load->model('dishe');
    check_session();
  }

  public function index(){
      $this->load->helper(array('form','zmform'));
      
      // 菜品和套餐列表      
      $data['itemlist1']=  $this->dishe->get_dishes(0);
      $data['itemlist2']=  $this->dishe->get_dishes(1);
      
      // 菜品类别数据
      $data['catas']=  $this->dishe->get_catas();

      $this->load->view('_common/header');
      
      show_nav(11);
  
      $this->load->view('dishes/list', $data);
  
      $this->load->view('_common/footer');
  }

  public function detail($sid){
      $data['shop'] = $this->shop->get_shop($sid);
      if (empty($data['shop'])) show_404();

      $this->load->helper('form');
      $this->load->view('_common/header');
      show_nav(11);
      
      $this->load->view('shops/detail', $data);
      
      $this->load->view('_common/footer');	  
}

  public function save() {	
	$this->shop->save($this->input->post());
	redirect('shops');
  }
  
  public function edit($sid) {	
	  $data['shop'] = $this->shop->get_shop($sid);
	  if (empty($data['shop'])) show_404();

	  $this->load->helper(array('form','zmform'));
	
	  $this->load->view('_common/header');
	  show_nav(11);
	  
	  $this->load->view('shops/edit', $data);
	  $this->load->view('_common/footer');	  
  }
  
  public function link() {
	$shopid=$this->input->post("shop_id");
	if ($shopid) {
	  $this->shop->link($this->input->post());
	  redirect('shops/'.$shopid);
	} else {
	  redirect('shops');
	}
	
  }  

  
}