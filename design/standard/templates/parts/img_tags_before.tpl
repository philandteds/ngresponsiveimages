        {if and( or( and( is_set( $responsive_image_class ), $responsive_image_class|count ), and( ezini_hasvariable( 'Responsive', 'AlwaysResponsive', 'ngresponsiveimages.ini' ), ezini( 'Responsive', 'AlwaysResponsive', 'ngresponsiveimages.ini' )|eq('enabled')) ), ezini_hasvariable( $responsive_image_class, 'DefaultMap', 'ngresponsiveimages.ini' ), is_set($responsive_disabled)|not )}
            {def $mq_expressions = array()}
            {set $responsive_enabled = true()}
            {if ezini_hasvariable( 'Responsive', 'MediaQueryExpressions', 'ngresponsiveimages.ini' )}
                {set $mq_expressions = ezini( 'Responsive', 'MediaQueryExpressions', 'ngresponsiveimages.ini' )}
            {/if}

            {def $mq_mappings = ezini( $responsive_image_class, 'MediaQueryMappings', 'ngresponsiveimages.ini' )|reverse
                 $img_alias = ''
                 $img_url = ''
                 $smallest_img = array()}
                {ezpagedata_set( concat('use_picture_tag', $attribute.object.id), false() )}
                {set-block variable=$sources}
                {foreach $mq_mappings as $screen => $mq_map_alias}
                    {if and( is_set( $mq_expressions[$screen] ), $mq_expressions[$screen]|count )}
                        {set 
                            $img_alias = concat('image', cond( $mq_map_alias|extract($responsive_image_class|count_chars()|inc)|eq(''), '', true(), concat( '_', $mq_map_alias|extract($responsive_image_class|count_chars()|inc))))
                            $img_url = $image_content[$mq_map_alias].url}
                        {if and( is_set($attribute.object.data_map[$img_alias]), $attribute.object.data_map[$img_alias].has_content )}
                            {ezpagedata_set( 'smallest_img', $img_alias )}
                            {set $smallest_img = $attribute.object.data_map[$img_alias]}
                            {set $img_url = $attribute.object.data_map[$img_alias].content[$mq_map_alias].url}
                            {if $img_alias|ne('image')}
                                {ezpagedata_set( concat('use_picture_tag', $attribute.object.id), true() )}
                            {/if}
                        {elseif and( is_set($smallest_img), $smallest_img|ne('') )}
                            {set $img_url = $smallest_img.content[$mq_map_alias].url}
                        {/if}
                        <source srcset={$img_url|ezroot()} media="{$mq_expressions[$screen]}" />
                    {/if}
                {/foreach}
                {/set-block}
                {def $use_pic_tag = concat('use_picture_tag', $attribute.object.id)}
                {set $use_pic_tag = cond( is_set($#persistent_variable[$use_pic_tag]), $#persistent_variable[$use_pic_tag], true(), false() )}
                {if $use_pic_tag}
                    <picture>{$sources}
                {/if}
                
            {undef $mq_expressions $mq_mappings $img_alias $img_url}
            
        {/if}
