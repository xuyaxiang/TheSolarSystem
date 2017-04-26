precision mediump float;
varying lowp vec4 colorVarying;
uniform sampler2D tex;
varying vec2 TextureCoordsOut;
void main()
{
    gl_FragColor = colorVarying * texture2D(tex,TextureCoordsOut);
}
