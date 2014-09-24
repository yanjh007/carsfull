<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

// 默认和特别路由
$route['default_controller'] = "home";
$route['login']  = 'home/login';
$route['logout'] = 'home/logout';
// 服务
$route['s'] = 'service';
$route['s/([a-z]+)/([a-z]+)'] = 'service/$1/$2';

// 404
$route['404_override'] = '';


// 通用控制器
$route['([a-z]+s)'] = '$1';
$route['([a-z]+s)/(:num)/([a-z_0-9]+)'] = '$1/$3/$2'; 
$route['([a-z]+s)/(:num)'] = '$1/view/$2';
$route['([a-z]+s)/(([a-z]+s))'] = '$1/$2'; //save，link, action

/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
|
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|
|	example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
|	http://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There area two reserved routes:
|
|	$route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
|	$route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router what URI segments to use if those provided
| in the URL cannot be matched to a valid route.
|
*/



/* End of file routes.php */
/* Location: ./application/config/routes.php */