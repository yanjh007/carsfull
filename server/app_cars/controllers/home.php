<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Home extends CI_Controller {
	public function __construct() {
		parent::__construct();
	}

	public function index() {
		check_session();

		$this->load->view('_common/header');

		show_nav(0); //标题，导航栏			

		$this->load->view('_common/home');
		$this->load->view('_common/footer');
	}

	public function login() {
   		if ($this->input->post('hash')) { // Post
			$this->load->library('form_validation');
			$this->load->model('user','',TRUE); //加载用户模型
 
   			$this->form_validation->set_rules('username', 'Username', 'trim|required|xss_clean');
   			$this->form_validation->set_rules('password', 'Password', 'trim|required|xss_clean|callback_check_passwd');
 
   			if($this->form_validation->run() == TRUE) { //验证成功 并转向主页
   				 redirect('home', 'refresh');
   			}
   		}

   		//非提交或验证失败
	    $this->load->helper(array('form'));
		$this->load->view('_common/login');
   	}

   	function logout() {
		$this->session->unset_userdata('logged_in');
		redirect('login');
   	}

   	// 密码检查回调
   	function check_passwd() {
   		$hash=$this->input->post('hash');
   		$username= substr($hash, 40);

  		$user = $this->user->get_user_by_login($username);
		if ($user) {
   			$password= substr($hash,0,40);
		  	if ($password == $user->passwd) {
		  		  $sess_array = array(
		  			  	'id'    => $user->id,
              			'login' => $user->login,
              			'role'  => $user->role,
						'name'  => $user->name
		  			);
       			$this->session->set_userdata('logged_in', $sess_array);
       			return TRUE;
       		}
  		} 
  		$this->form_validation->set_message('check_passwd', '用户名和密码不匹配');
  		return FALSE;
  	}
}

/* End of file home.php */
/* Location: ./application/controllers/welcome.php */