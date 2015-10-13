        {if and( is_set( $responsive_image_class ), $responsive_image_class|count, ezini_hasvariable( $responsive_image_class, 'DefaultMap', 'ngresponsiveimages.ini' ), is_set($responsive_disabled)|not )}
            {def $mq_expressions = array()}
            {set $responsive_enabled = true()}
            {if ezini_hasvariable( 'Responsive', 'MediaQueryExpressions', 'ngresponsiveimages.ini' )}
                {set $mq_expressions = ezini( 'Responsive', 'MediaQueryExpressions', 'ngresponsiveimages.ini' )}
            {/if}

            {def $mq_mappings = ezini( $responsive_image_class, 'MediaQueryMappings', 'ngresponsiveimages.ini' )}
                <picture>
                {foreach $mq_mappings as $screen => $mq_map_alias}
                    {if and( is_set( $mq_expressions[$screen] ), $mq_expressions[$screen]|count )}
                        <source srcset={$image_content[$mq_map_alias].url|ezroot()} media="{$mq_expressions[$screen]}" />
                    {/if}
                {/foreach}
            {undef $mq_expressions $mq_mappings}
            
        {/if}
