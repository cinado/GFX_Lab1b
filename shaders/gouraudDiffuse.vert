precision mediump float;

attribute vec4 vertexPosition;
attribute vec4 vertexColor;
attribute vec3 vertexNormal;

uniform mat4 modelViewMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform mat3 normalMatrix;

uniform vec4 u_lightCoords;
uniform vec4 u_ambientProduct;
uniform vec4 u_diffuseProduct;

varying vec4 fragmentColor;

void main() {

    // Transform light position to view space
    vec4 lightPosition = viewMatrix * u_lightCoords;
    // Transform vertex position to view space
    vec4 viewPosition = modelViewMatrix * vertexPosition;

    // Calculate and normalize light vector - L
    vec3 lightVector = normalize(lightPosition.xyz - viewPosition.xyz);
    // Transform and normalize the normal - N
    vec3 transformedNormal = normalize(normalMatrix * vertexNormal);

    // Calculate light intensity
    // This can be negative, so just make negative values 0
    float lightIntensity = max(dot(lightVector, transformedNormal), 0.0);

    gl_Position = projectionMatrix * viewPosition; 
    // Multiply vertex color with lightIntensity
    fragmentColor = vertexColor * (lightIntensity * u_diffuseProduct + u_ambientProduct);
    // set alpha value to 1 again
    fragmentColor.a = 1.0;
}
