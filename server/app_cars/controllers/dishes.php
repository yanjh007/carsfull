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
      $data['dishes'] = $this->shop->get_shop($sid);
      if (empty($data['dishes'])) show_404();

      $this->load->helper('form');
      $this->load->view('_common/header');
      show_nav(11);
      
      $this->load->view('dishes/detail', $data);
      
      $this->load->view('_common/footer');	  
}

  public function save() {	
	$this->shop->save($this->input->post());
	redirect('dishes');
  }
  
  public function edit($id) {
    $dishe=$this->dishe->get_item($id);
    if (empty($dishe)) show_404();
    $data['item'] = $dishe;
    
    $this->load->helper(array('form','zmform'));
  
    $this->load->view('_common/header');
    show_nav(11);
    
    if ($dishe["dtype"]==0) { //单品
      $data['catas1'] = $this->dishe->get_catas1($id);
      
      $data['catas2'] = $this->dishe->get_catas2($id);
      
      $this->load->view('dishes/edit0', $data);
    } else { //套餐
      $this->load->view('dishes/edit1', $data);
    }
    $this->load->view('_common/footer');	  
  }
  
  public function link($id) {
    $rid=$this->input->get("rid");
    if ($rid) {
      $rname=$this->input->get("rname");
      $this->load->model('link');
      
      $this->link->link(Link::TYPE_DISHE_CATAS,$id,"",$rid,$rname);
      redirect('dishes/'.$id."/edit");
    } else {
      redirect('dishes');
    }
  }
  
  public function unlink($id) {
    $rid=$this->input->get("rid");
    if ($rid) {
      $this->load->model('link');      
      $this->link->unlink(Link::TYPE_DISHE_CATAS,$id,$rid);
      redirect('dishes/'.$id."/edit");
    } else {
      redirect('dishes');
    }
  }  
  
}