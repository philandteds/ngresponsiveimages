        {if and( is_set( $responsive_image_class ), $responsive_image_class|count, ezini_hasvariable( $responsive_image_class, 'DefaultMap', 'ngresponsiveimages.ini' ), is_set($responsive_disabled)|not )}
           </picture> 
        {/if}
