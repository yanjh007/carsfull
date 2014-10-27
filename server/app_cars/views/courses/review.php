<?php
    $MODULE_PATH="courses/";
?>
<div class="container">
    <div class="page-header">
      <h1>答题批覆 <small><?php  ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">信息</div>
        <div class="panel-body">
            <?php
            $qorder=$item["qorder"];
            $content=$item["content"];
            $json=json_decode($content,true);
            
            $content=$json["content"];
            $qtype=0;
            var_dump($content);
            foreach ($content as $citem) {
                if ($qorder== $citem["qorder"]) {
                    $qtype=$citem["qtype"];
                    $str=$citem["content"];
                    var_dump($citem);
                    break;
                }
            }
            
            $list=explode($str,"\n\n\n");
            
            echo "题目类型: ".$qtype."<br>";
            echo "题目内容: ".$list[0]."<br>";
            echo "选项: ".$list[1]."<br>";
            
            echo "学员代码: ".$item["snumber"]."<br>";
            echo "学员姓名: ".$item["name"]."<br>";
            echo "学员答案: ".$item["answer"]."<br>";
            echo "结果状态: ".$item["status"]."<br>";
            echo "得分: ".$item["score"]."<br>";
            ?>
        </div>
    </div>
    
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">批复</div>
        <div class="panel-body">
            <?php
                zm_form_open (0,$MODULE_PATH."/save_review");
                zm_form_input(0,"修正得分","score",   $item["score"]);
                zm_form_textarea(0,"批复说明","descp",   $item["rnote"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <?php
                    zm_btn_submit("保存");
                    zm_btn_submit("保存到下一题");
                    zm_btn_back($MODULE_PATH)
                ?>
               
              </div>
            </div>
          </form>
        </div>
    </div>

</div>