        {def $use_pic_tag = concat('use_picture_tag', $attribute.object.id)
             $use_pic_tag = cond( is_set($#persistent_variable[$use_pic_tag]), $#persistent_variable[$use_pic_tag], true(), false() )}
        {if and( is_set( $responsive_image_class ), $responsive_image_class|count, ezini_hasvariable( $responsive_image_class, 'DefaultMap', 'ngresponsiveimages.ini' ),  $use_pic_tag )}
           </picture> 
        {/if}
        {undef $use_pic_tag}
