attribute vec3 position;
attribute vec2 TextureCoords;
uniform lowp mat4 projectionMatrix;
uniform lowp mat4 modelMatrix;
uniform lowp mat4 viewMatrix;
varying lowp vec4 colorVarying;
varying vec2 TextureCoordsOut;
void main()
{
    gl_Position =projectionMatrix * viewMatrix * modelMatrix * vec4(position,1);
    colorVarying = vec4(1,1,1,1);
    TextureCoordsOut = TextureCoords;
}
