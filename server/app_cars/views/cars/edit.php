<div class="container">
    <div class="page-header">
      <h1>客户管理 <small><?php echo $client["name"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑客户</div>
        <div class="panel-body">
            <?= form_open('clients/save',array('class' => 'form-horizontal', 'role' => 'form')); ?>
            <?= form_hidden('client_id', $client["id"]); ?>
            <div class="form-group">
              <label for="inputEmail3" class="col-sm-1 control-label">名 称</label>
              <div class="col-sm-6">
                <?= form_input(array('name' => 'name',
                                    'id'    => 'username',
                                    'class' => 'form-control',
                                    'value' => $client["name"] ,
                                        )); ?>
              </div>
            </div>
            <div class="form-group">
              <label for="inputPassword3" class="col-sm-1 control-label">手 机</label>
              <div class="col-sm-6">
                <?= form_input(array('name'  => 'mobile',
                                            'id'    => 'mobile',
                                            'class' => 'form-control',
                                            'value' =>  $client["mobile"],
                                        )); ?>
              </div>
            </div>
            <div class="form-group">
              <label for="inputPassword3" class="col-sm-1 control-label">IM 方式</label>
              <div class="col-sm-6">
                <?= form_input(array('name'=> 'im',
                                   'id'    => 'im',
                                   'class' => 'form-control',
                                   'value' =>  $client["wechat"] ,
                                        )); ?>
              </div>
            </div>
            <div class="form-group">
              <label for="inputPassword3" class="col-sm-1 control-label">地 址</label>
              <div class="col-sm-6">
                <textarea class="form-control" rows="3"></textarea>
              </div>
            </div>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <button type="submit" class="btn btn-primary">保 存</button>&nbsp&nbsp&nbsp
                <button class="btn btn-default" type="button" id="btn_back" onclick="javascript:history.back()">返 回</button>
              </div>
            </div>
          </form>
        </div>
    </div>
</div>