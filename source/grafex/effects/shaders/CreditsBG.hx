package grafex.effects.shaders;

import util.FlxShaderToyShader;

class CreditsBG extends FlxShaderToyShader {
	public function new(){
		super('
		    void mainImage( out vec4 fragColor, in vec2 fragCoord )
            {
                // normalized pixel coordinates
                vec2 p = 6.0*fragCoord/iResolution.xy;
	
                // pattern
                float f = sin(p.x + sin(2.0*p.y + iTime)) +
                          sin(length(p)+iTime) +
                          0.5*sin(p.x*2.5+iTime);
    
                // color
                vec3 col = 0.6 + 0.3*cos(f+vec3(0.3,2.1,4.2));

                // putput to screen
                fragColor = vec4(col,1.0);
            }
		');
	}
}