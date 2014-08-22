<?php
/*
 * URL helpers, this file extends
 * the current URL helper that
 * CodeIgniter includes.
*/

/**
 * asset_url
 *
 * This function OVERRIDES the current
 * CodeIgniter base_url function to support
 * CDN'ized content.
 */
function check_session()
{
   $CI=&get_instance();
   $user = $CI->session->userdata('logged_in'); 

   if (!$user) {
      redirect('/login', 'refresh');
   } 
}

function show_nav($current_tab)
{   
   $CI=&get_instance();
   $user = $CI->session->userdata('logged_in'); 
   if (!$user) {
      redirect('/login', 'refresh');
   } 

   $navdata['username'] = $user['name']; 
   $navdata['userrole'] = $user['role']; // 将title中的第一个字符大写
   
   $CI->load->helper('url');      
   $CI->load->view('_common/navbar',$navdata);
}


