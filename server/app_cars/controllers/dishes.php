<?php
class Dishes extends CI_Controller {

  public function __construct()
  {
    parent::__construct();
    $this->load->model('dishe');
    check_session();
  }

  public function index(){
    $filter = $this->input->get("filter");
    
    if ($filter) {
      if ($filter==-1) { //单品
	$data["showmode"]=1;
	$data["subtitle"]="单品";
	$data['itemlist1']=  $this->dishe->get_dishes(0);
      } elseif ($filter==-2) { //套餐
	$data["showmode"]=2;
	$data["subtitle"]="套餐";
	$data['itemlist2']=  $this->dishe->get_dishes(1);
      } else{
	$data["showmode"]=3;

	$data["subtitle"] = $this->dishe->get_cata_name($filter);

	$data['itemlist1']=  $this->dishe->get_cata_dishes(0,$filter);
	$data['itemlist2']=  $this->dishe->get_cata_dishes(1,$filter);
      }
    } else {
      $data["showmode"]=0;
      
      // 菜品和套餐列表      
      $data['itemlist1']=  $this->dishe->get_dishes(0);
      $data['itemlist2']=  $this->dishe->get_dishes(1);
    }
      $this->load->helper(array('form','zmform'));
      
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

  public function save($id) {
    $this->dishe->save($id,$this->input->post());
    redirect('dishes');      
  }
  
  public function addcata($id) {
    $post=$this->input->post();
    if	($post && $post["name"]) {
      $this->load->model("dic");
      $this->dic->add_item(8,$post["name"],100); //类别编码，名称和位置1或100
    }
    
    redirect('dishes');      
  }
  
  public function delete($id) {
    $action=$this->input->get("action");
    $this->dishe->save($id,$action,$this->input->post());
    redirect('dishes');      
  }
  
  public function edit($id) {
    $dishe=$this->dishe->get_item($id);
    if (empty($dishe)) show_404();
    $data['item'] = $dishe;
    
    $this->load->helper(array('form','zmform'));
  
    $this->load->view('_common/header');
    show_nav(11);
    
    $data['links0'] = $this->dishe->get_links($id,0);
    $data['links1'] = $this->dishe->get_links($id,1);

    $data['links2'] = $this->dishe->get_links($id,2);
    $data['links3'] = $this->dishe->get_links($id,3);

    $this->load->view('dishes/edit', $data);
    
    $this->load->view('_common/footer');	  
  }
  
  // 加入分类
  public function link($id) {
    $action=$this->input->get("action");
    
    $rid=$this->input->get("rid");
    if ($rid) {
      $this->load->model('link');
      if ($action==0) { //关联类别 l-菜品 r-类别dic t-10
	$rname=$this->input->get("rname");      
	$this->link->link(Link::TYPE_DISHE_CATAS,$id,"",$rid,$rname);
      } else if ($action==1) { //取消类别管理
	$this->link->unlink(Link::TYPE_DISHE_CATAS,$id,$rid);
      } else if ($action==2) { //关联套餐 l-菜品 r-套餐 t-11
	$rname=$this->input->get("rname");      
	$this->link->link(Link::TYPE_DISHE_SETS,$id,"",$rid,$rname);
      } else if ($action==3) { //取消关联套餐 
	$this->link->unlink(Link::TYPE_DISHE_SETS,$id,$rid);	
      }
      redirect('dishes/'.$id."/edit");
    } else {
      redirect('dishes');
    }
  }
  
  
  // ajax delete
  public function jdelete($id) {	
      if ($this->input->server('REQUEST_METHOD')==="DELETE") {
	$this->dishe->remove($id);
	echo "OK";
      }
  } 
  
}