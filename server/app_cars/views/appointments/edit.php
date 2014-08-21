<div class="container">
    <div class="page-header">
      <h1>店铺管理 <small><?php echo $shop["name"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑店铺</div>
        <div class="panel-body">
            <?= form_open('shops/save',array('class' => 'form-horizontal', 'role' => 'form')); ?>
            <?= form_hidden('shop_id', $shop["id"]); ?>
            <div class="form-group">
              <label for="inputPassword3" class="col-sm-1 control-label">编 码</label>
              <div class="col-sm-6">
                <?= form_input(array('name' => 'scode',
                                    'id'    => 'scode',
                                    'class' => 'form-control',
                                    'value' =>  $shop["scode"],
                                        )); ?>
              </div>
            </div>
            <div class="form-group">
              <label for="inputEmail3" class="col-sm-1 control-label">名 称</label>
              <div class="col-sm-6">
                <?= form_input(array('name' => 'name',
                                    'id'    => 'username',
                                    'class' => 'form-control',
                                    'value' => $shop["name"] ,
                                        )); ?>
              </div>
            </div>
            <div class="form-group">
              <label for="inputPassword3" class="col-sm-1 control-label">联系方式</label>
              <div class="col-sm-6">
                <?= form_input(array('name'=> 'contact',
                                   'id'    => 'contact',
                                   'class' => 'form-control',
                                   'value' =>  $shop["contact"] ,
                                        )); ?>
              </div>
            </div>
            <div class="form-group">
              <label for="inputPassword3" class="col-sm-1 control-label">地 址</label>
              <div class="col-sm-6">
                <?= form_input(array('name'=> 'address',
                                      'id' => 'address',
                                   'class' => 'form-control',
                                   'value' =>  $shop["address"] ,
                                    'rows' =>  "3",
                                        )); ?>
              </div>
            </div>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <button type="submit" class="btn btn-primary">保 存</button>&nbsp&nbsp&nbsp
                <button class="btn btn-danger">删 除</button>&nbsp&nbsp&nbsp
                <button class="btn btn-default" type="button" id="btn_back" onclick="javascript:history.back()">返 回</button>
              </div>
            </div>
          </form>
        </div>
    </div>
</div>