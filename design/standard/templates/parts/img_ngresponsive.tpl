        {if and( is_set( $responsive_image_class ), $responsive_image_class|count, ezini_hasvariable( $responsive_image_class, 'DefaultMap', 'ngresponsiveimages.ini' ), is_set($responsive_disabled)|not )}
            {def $mq_expressions = array()}
            {set $responsive_enabled = true()}
            {if ezini_hasvariable( 'Responsive', 'MediaQueryExpressions', 'ngresponsiveimages.ini' )}
                {set $mq_expressions = ezini( 'Responsive', 'MediaQueryExpressions', 'ngresponsiveimages.ini' )}
            {/if}
            {def $mq_mappings = ezini( $responsive_image_class, 'MediaQueryMappings', 'ngresponsiveimages.ini' )
                 $use_pic_tag = concat('use_picture_tag', $attribute.object.id)
                 $default_map = ezini( $responsive_image_class, 'DefaultMap', 'ngresponsiveimages.ini' )}
            {set $use_pic_tag = cond( is_set($#persistent_variable[$use_pic_tag]), $#persistent_variable[$use_pic_tag], true(), false() )}
            {if $use_pic_tag|not}
                sizes="{foreach $mq_mappings as $screen => $mq_map_alias}
                    {if and( is_set( $mq_expressions[$screen] ), $mq_expressions[$screen]|count )}
                        {$mq_expressions[$screen]|wash}
                        {delimiter}, {/delimiter}
                    {/if}
                {/foreach}"
            {/if}
                srcset="{if $use_pic_tag|not}{foreach $mq_mappings as $screen => $mq_map_alias}
                            {if and( is_set( $mq_expressions[$screen] ), $mq_expressions[$screen]|count )}
                                {$image_content[$mq_map_alias].url|ezroot('no')} {$image_content[$mq_map_alias].width|wash}w, {/if}
                        {/foreach}{/if}
                        {if is_set($#persistent_variable.smallest_img)}{set $image_content = $attribute.object.data_map[$#persistent_variable.smallest_img].content}{/if}
                        {$image_content[$default_map].url|ezroot('no')} {$image_content[$default_map].width|wash}w"
            {undef $mq_expressions $mq_mappings}
            
        {/if}
