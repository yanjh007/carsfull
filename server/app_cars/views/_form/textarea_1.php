<div class="form-group">
  <label ><?= $title ?></label>
  <?= form_textarea(array( 'name'  => $name,
                        'id'    => $name,
                        'class' => 'form-control',
                        'value' => $value,
                        'rows'  => "3"
                            )); ?>
</div>