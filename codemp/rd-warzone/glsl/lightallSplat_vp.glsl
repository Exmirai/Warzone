#define USE_EDGE_TESSELLATION

attribute vec2 attr_TexCoord0;

attribute vec2 attr_TexCoord1;


#ifdef __VBO_PACK_COLOR__
attribute float attr_Color;
#else //!__VBO_PACK_COLOR__
attribute vec4 attr_Color;
#endif //__VBO_PACK_COLOR__

attribute vec3 attr_Position;
attribute vec3 attr_Normal;

attribute vec3 attr_Position2;
attribute vec3 attr_Normal2;
attribute vec4 attr_BoneIndexes;
attribute vec4 attr_BoneWeights;

#if defined(USE_BINDLESS_TEXTURES)
layout(std140) uniform u_bindlessTexturesBlock
{
uniform sampler2D					u_DiffuseMap;
uniform sampler2D					u_LightMap;
uniform sampler2D					u_NormalMap;
uniform sampler2D					u_DeluxeMap;
uniform sampler2D					u_SpecularMap;
uniform sampler2D					u_PositionMap;
uniform sampler2D					u_WaterPositionMap;
uniform sampler2D					u_WaterHeightMap;
uniform sampler2D					u_HeightMap;
uniform sampler2D					u_GlowMap;
uniform sampler2D					u_EnvironmentMap;
uniform sampler2D					u_TextureMap;
uniform sampler2D					u_LevelsMap;
uniform sampler2D					u_CubeMap;
uniform sampler2D					u_SkyCubeMap;
uniform sampler2D					u_SkyCubeMapNight;
uniform sampler2D					u_EmissiveCubeMap;
uniform sampler2D					u_OverlayMap;
uniform sampler2D					u_SteepMap;
uniform sampler2D					u_SteepMap1;
uniform sampler2D					u_SteepMap2;
uniform sampler2D					u_SteepMap3;
uniform sampler2D					u_WaterEdgeMap;
uniform sampler2D					u_SplatControlMap;
uniform sampler2D					u_SplatMap1;
uniform sampler2D					u_SplatMap2;
uniform sampler2D					u_SplatMap3;
uniform sampler2D					u_RoadsControlMap;
uniform sampler2D					u_RoadMap;
uniform sampler2D					u_DetailMap;
uniform sampler2D					u_ScreenImageMap;
uniform sampler2D					u_ScreenDepthMap;
uniform sampler2D					u_ShadowMap;
uniform sampler2D					u_ShadowMap2;
uniform sampler2D					u_ShadowMap3;
uniform sampler2D					u_ShadowMap4;
uniform sampler2D					u_ShadowMap5;
uniform sampler2D					u_MoonMaps[4];
};
#else //!defined(USE_BINDLESS_TEXTURES)
uniform sampler2D					u_HeightMap;
uniform sampler2D					u_RoadsControlMap;
#endif //defined(USE_BINDLESS_TEXTURES)

uniform vec4				u_Settings0; // useTC, useDeform, useRGBA, isTextureClamped
uniform vec4				u_Settings1; // useVertexAnim, useSkeletalAnim, useFog, is2D
uniform vec4				u_Settings2; // LIGHTDEF_USE_LIGHTMAP, LIGHTDEF_USE_GLOW_BUFFER, LIGHTDEF_USE_CUBEMAP, LIGHTDEF_USE_TRIPLANAR
uniform vec4				u_Settings3; // LIGHTDEF_USE_REGIONS, LIGHTDEF_IS_DETAIL

#define USE_TC				u_Settings0.r
#define USE_DEFORM			u_Settings0.g
#define USE_RGBA			u_Settings0.b
#define USE_TEXTURECLAMP	u_Settings0.a

#define USE_VERTEX_ANIM		u_Settings1.r
#define USE_SKELETAL_ANIM	u_Settings1.g
#define USE_FOG				u_Settings1.b
#define USE_IS2D			u_Settings1.a

#define USE_LIGHTMAP		u_Settings2.r
#define USE_GLOW_BUFFER		u_Settings2.g
#define USE_CUBEMAP			u_Settings2.b
#define USE_TRIPLANAR		u_Settings2.a

#define USE_REGIONS			u_Settings3.r
#define USE_ISDETAIL		u_Settings3.g

uniform vec4						u_Local1; // MAP_SIZE, sway, overlaySway, materialType
uniform vec4						u_Local2; // hasWaterEdgeMap, haveNormalMap, 0.0, SHADER_WATER_LEVEL
uniform vec4						u_Local3; // hasSplatMap1, hasSplatMap2, hasSplatMap3, hasSplatMap4
uniform vec4						u_Local4; // stageNum, glowStrength, r_showsplat, 0.0
uniform vec4						u_Local8;
uniform vec4						u_Local9; // testvalue0, 1, 2, 3
uniform vec4						u_Local13; // hasSteepMap, hasSteepMap1, hasSteepMap2, hasSteepMap3
uniform vec4						u_Local14; // grassAliasImage
uniform vec4						u_Local15; // seaGrassAliasImage
uniform vec4						u_Local16; // GRASS_ENABLED, GRASS_DISTANCE, GRASS_MAX_SLOPE, 0.0

#define SHADER_MAP_SIZE				u_Local1.r
#define SHADER_SWAY					u_Local1.g
#define SHADER_OVERLAY_SWAY			u_Local1.b
#define SHADER_MATERIAL_TYPE		u_Local1.a

#define SHADER_HAS_WATEREDGEMAP		u_Local2.r
#define SHADER_HAS_NORMALMAP		u_Local2.g
//#define UNUSED					u_Local2.b
#define SHADER_WATER_LEVEL			u_Local2.a

#define SHADER_HAS_SPLATMAP1		u_Local3.r
#define SHADER_HAS_SPLATMAP2		u_Local3.g
#define SHADER_HAS_SPLATMAP3		u_Local3.b
#define SHADER_HAS_SPLATMAP4		u_Local3.a

#define SHADER_STAGE_NUM			u_Local4.r
#define SHADER_GLOW_STRENGTH		u_Local4.g
#define SHADER_SHOW_SPLAT			u_Local4.b
#define SHADER_GLOW_VIBRANCY		u_Local4.a

#define SHADER_HAS_STEEPMAP			u_Local13.r
#define SHADER_HAS_STEEPMAP1		u_Local13.g
#define SHADER_HAS_STEEPMAP2		u_Local13.b
#define SHADER_HAS_STEEPMAP3		u_Local13.a

#define GRASS_ENABLED				u_Local16.r
#define GRASS_DISTANCE				u_Local16.g
#define GRASS_MAX_SLOPE				u_Local16.b

#ifdef __CHEAP_VERTS__
uniform int					u_isWorld;
#endif //__CHEAP_VERTS__

uniform float	u_Time;

uniform vec2	u_textureScale;

uniform vec3   u_ViewOrigin;

uniform int    u_TCGen0;
uniform vec3   u_TCGen0Vector0;
uniform vec3   u_TCGen0Vector1;

uniform vec3   u_LocalViewOrigin;

uniform vec4   u_DiffuseTexMatrix;
uniform vec4   u_DiffuseTexOffTurb;

uniform int    u_ColorGen;
uniform int    u_AlphaGen;
uniform vec3   u_AmbientLight;
uniform vec3   u_DirectedLight;
uniform vec3   u_ModelLightDir;
uniform float  u_PortalRange;

uniform int    u_DeformGen;
uniform float  u_DeformParams[7];

uniform vec4   u_FogDistance;
uniform vec4   u_FogDepth;
uniform float  u_FogEyeT;
uniform vec4   u_FogColorMask;

uniform mat4   u_ModelViewProjectionMatrix;
//uniform mat4	u_ViewProjectionMatrix;
uniform mat4   u_ModelMatrix;
uniform mat4	u_NormalMatrix;

uniform vec4   u_BaseColor;
uniform vec4   u_VertColor;

uniform float  u_VertexLerp;
uniform mat4   u_BoneMatrices[MAX_GLM_BONEREFS];

uniform vec4  u_PrimaryLightOrigin;
uniform vec3  u_PrimaryLightColor;
uniform float u_PrimaryLightRadius;

#if defined(USE_TESSELLATION) || defined(USE_TESSELLATION_3D)
#ifdef USE_EDGE_TESSELLATION
uniform vec4						u_MapInfo; // MAP_INFO_SIZE[0], MAP_INFO_SIZE[1], MAP_INFO_SIZE[2], 0.0
uniform vec4						u_Mins;
uniform vec4						u_Maxs;

#define SHADER_HAS_SPLATMAP4		u_Local3.a
#define GRASS_DISTANCE_FROM_ROADS	u_Local8.r

uniform vec4 u_TesselationInfo;

#if defined(USE_TESSELLATION_3D)
uniform vec4 u_Tesselation3DInfo;
#define uTessAlpha u_Tesselation3DInfo.xyz
#define uRandomScale u_Tesselation3DInfo.w
#else //!defined(USE_TESSELLATION_3D)
#define uTessAlpha u_TesselationInfo.r
#endif //defined(USE_TESSELLATION_3D)

#endif //defined(USE_TESSELLATION) || defined(USE_TESSELLATION_3D)

out vec3 Normal_CS_in;
out vec2 TexCoord_CS_in;
out vec4 WorldPos_CS_in;
out vec3 ViewDir_CS_in;
out vec4 Color_CS_in;
out vec4 PrimaryLightDir_CS_in;
out vec2 TexCoord2_CS_in;
out vec3 Blending_CS_in;
out vec2 envTC_CS_in;
out float Slope_CS_in;
out float GrassSlope_CS_in;
#endif

varying vec2	var_TexCoords;
varying vec2	var_TexCoords2;
varying vec4	var_Color;
varying vec3	var_Normal;
varying vec3	var_ViewDir;
varying vec4	var_PrimaryLightDir;
varying vec3	var_vertPos;
varying vec3	var_Blending;
varying float	var_Slope;
varying float	var_GrassSlope;


const float VboUnpackX = 1.0/255.0;
const float VboUnpackY = 1.0/65025.0;
const float VboUnpackZ = 1.0/16581375.0;

vec4 DecodeFloatRGBA( float v ) {
	vec4 enc = vec4(1.0, 255.0, 65025.0, 16581375.0) * v;
	enc = fract(enc);
	enc -= enc.yzww * vec4(VboUnpackX, VboUnpackX, VboUnpackX,0.0);
	return enc;
}

vec4 CalcColor(vec3 position, vec3 normal)
{
	vec4 color;

#ifdef __CHEAP_VERTS__
	if (u_isWorld > 0)
	{
		color = u_VertColor + u_BaseColor;
	}
	else
#endif //__CHEAP_VERTS__
	{
//#ifdef __CHEAP_VERTS__
//		color = u_VertColor + u_BaseColor;
//#else //!__CHEAP_VERTS__
	#ifdef __VBO_PACK_COLOR__
		color = u_VertColor * DecodeFloatRGBA(attr_Color) + u_BaseColor;
	#else //!__VBO_PACK_COLOR__
		color = u_VertColor * attr_Color + u_BaseColor;
	#endif //__VBO_PACK_COLOR__
//#endif //__CHEAP_VERTS__
	}
	
	if (USE_RGBA > 0.0)
	{
		if (u_ColorGen == CGEN_LIGHTING_DIFFUSE)
		{
			float incoming = clamp(dot(normal, u_ModelLightDir), 0.0, 1.0);
			color.rgb = clamp(u_DirectedLight * incoming + u_AmbientLight, 0.0, 1.0);
		}

		if (u_ColorGen == CGEN_LIGHTING_WARZONE)
		{
			vec3 light = normalize(u_PrimaryLightOrigin.xyz - (position * u_PrimaryLightOrigin.w));
			float diffuse = clamp(pow(dot(normal, light), 16.0), 0.25, 1.0);
			vec3 reflected = -reflect(light, normal);
			vec3 viewer = normalize(u_LocalViewOrigin - position);
			float spec = clamp(pow(dot(reflected, viewer), 64.0), 0.25, 1.0);
			vec3 lColor = mix(u_PrimaryLightColor, vec3(1.0), 0.8);
			color.rgb = clamp(lColor * (diffuse + spec + 0.5), 0.0, 1.0);
		}
	
		if (u_AlphaGen == AGEN_LIGHTING_SPECULAR)
		{
			vec3 viewer = u_LocalViewOrigin - position;
			//vec3 lightDir = normalize(vec3(-960.0, 1980.0, 96.0) - position);
			vec3 lightDir = normalize(u_PrimaryLightOrigin.xyz);
			//vec3 lightDir = normalize(u_PrimaryLightOrigin.xyz - position);
			vec3 reflected = -reflect(lightDir, normal);
		
			color.a = clamp(dot(reflected, normalize(viewer)), 0.0, 1.0);
			color.a *= color.a;
			color.a *= color.a;
		}
		else if (u_AlphaGen == AGEN_PORTAL)
		{
			//vec3 viewer = u_LocalViewOrigin - position;
			vec3 viewer = u_ViewOrigin - position;
			color.a = clamp(length(viewer) / u_PortalRange, 0.0, 1.0);
		}
	}
	
	return color;
}

#if 0
float CalcFog(vec3 position)
{
	float s = dot(vec4(position, 1.0), u_FogDistance) * 8.0;
	float t = dot(vec4(position, 1.0), u_FogDepth);

	float eyeOutside = float(u_FogEyeT < 0.0);
	float fogged = float(t < eyeOutside);

	t += 1e-6;
	t *= fogged / (t - u_FogEyeT * eyeOutside);

	return s * t;
}
#endif

void GetBlending(vec3 normal)
{
	vec3 blend_weights = abs(normalize(normal.xyz));   // Tighten up the blending zone:
	blend_weights = (blend_weights - 0.2) * 7.0;
	blend_weights = max(blend_weights, 0.0);      // Force weights to sum to 1.0 (very important!)
	blend_weights /= vec3(blend_weights.x + blend_weights.y + blend_weights.z);
	var_Blending = blend_weights;
}

float normalToSlope(in vec3 normal) {
#if 1
	float pitch = 1.0 - (normal.z * 0.5 + 0.5);
	return pitch * 180.0;
#else
	float	forward;
	float	pitch;

	if (normal.g == 0.0 && normal.r == 0.0) {
		if (normal.b > 0.0) {
			pitch = 90;
		}
		else {
			pitch = 270;
		}
	}
	else {
		forward = sqrt(normal.r*normal.r + normal.g*normal.g);
		pitch = (atan(normal.b, forward) * 180 / M_PI);
		if (pitch < 0.0) {
			pitch += 360;
		}
	}

	pitch = -pitch;

	if (pitch > 180)
		pitch -= 360;

	if (pitch < -180)
		pitch += 360;

	pitch += 90.0f;

	return length(pitch);
#endif
}

#if defined(USE_TESSELLATION) && defined(USE_EDGE_TESSELLATION)
#define HASHSCALE1 .1031

float random(vec2 p)
{
	vec3 p3 = fract(vec3(p.xyx) * HASHSCALE1);
	p3 += dot(p3, p3.yzx + 19.19);
	return fract((p3.x + p3.y) * p3.z);
}

// 2D Noise based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise(in vec2 st) {
	vec2 i = floor(st);
	vec2 f = fract(st);

	// Four corners in 2D of a tile
	float a = random(i);
	float b = random(i + vec2(1.0, 0.0));
	float c = random(i + vec2(0.0, 1.0));
	float d = random(i + vec2(1.0, 1.0));

	// Smooth Interpolation

	// Cubic Hermine Curve.  Same as SmoothStep()
	vec2 u = f*f*(3.0 - 2.0*f);
	// u = smoothstep(0.,1.,f);

	// Mix 4 coorners percentages
	return mix(a, b, u.x) +
		(c - a)* u.y * (1.0 - u.x) +
		(d - b) * u.x * u.y;
}

float GetRoadFactor(vec2 pixel)
{
	float roadScale = 1.0;

	if (SHADER_HAS_SPLATMAP4 > 0.0)
	{// Also grab the roads map, if we have one...
		float road = texture(u_RoadsControlMap, pixel).r;

		if (road > GRASS_DISTANCE_FROM_ROADS)
		{
			roadScale = 0.0;
		}
		else if (road > 0.0)
		{
			roadScale = 1.0 - clamp(road / GRASS_DISTANCE_FROM_ROADS, 0.0, 1.0);
		}
		else
		{
			roadScale = 1.0;
		}
	}
	else
	{
		roadScale = 1.0;
	}

	return 1.0 - clamp(roadScale * 0.6 + 0.4, 0.0, 1.0);
}

float GetHeightmap(vec2 pixel)
{
	return texture(u_HeightMap, pixel).r;
}

vec2 GetMapTC(vec3 pos)
{
	vec2 mapSize = u_Maxs.xy - u_Mins.xy;
	return (pos.xy - u_Mins.xy) / mapSize;
}

float LDHeightForPosition(vec3 pos)
{
	return noise(vec2(pos.xy * 0.00875));
}

float OffsetForPosition(vec3 pos)
{
	vec2 pixel = GetMapTC(pos);
	float roadScale = GetRoadFactor(pixel);
	float SmoothRand = LDHeightForPosition(pos);
	float offsetScale = SmoothRand * clamp(1.0 - roadScale, 0.75, 1.0);

	float offset = max(offsetScale, roadScale) - 0.5;
	return offset * uTessAlpha;
}
#endif //defined(USE_TESSELLATION) && defined(USE_EDGE_TESSELLATION)

#if defined(USE_TESSELLATION_3D) && defined(USE_EDGE_TESSELLATION)
#define HASHSCALE1 .1031

vec3 hash(vec3 p3)
{
	p3 = fract(p3 * HASHSCALE1);
	p3 += dot(p3, p3.yxz+19.19);
	return fract((p3.xxy + p3.yxx)*p3.zyx);
}

vec3 noise( in vec3 x )
{
	vec3 p = floor(x);
	vec3 f = fract(x);
	f = f*f*(3.0-2.0*f);
	
	return mix(	mix(mix( hash(p+vec3(0,0,0)), 
						hash(p+vec3(1,0,0)),f.x),
					mix( hash(p+vec3(0,1,0)), 
						hash(p+vec3(1,1,0)),f.x),f.y),
				mix(mix( hash(p+vec3(0,0,1)), 
						hash(p+vec3(1,0,1)),f.x),
					mix( hash(p+vec3(0,1,1)), 
						hash(p+vec3(1,1,1)),f.x),f.y),f.z);
}

const mat3 m3 = mat3( 0.00,  0.80,  0.60,
					-0.80,  0.36, -0.48,
					-0.60, -0.48,  0.64 );
vec3 fbm(in vec3 q)
{
	vec3 f  = 0.5000*noise( q ); q = m3*q*2.01;
	f += 0.2500*noise( q ); q = m3*q*2.02;
	f += 0.1250*noise( q ); q = m3*q*2.03;
	f += 0.0625*noise( q ); q = m3*q*2.04; 
#if 0
	f += 0.03125*noise( q ); q = m3*q*2.05; 
	f += 0.015625*noise( q ); q = m3*q*2.06; 
	f += 0.0078125*noise( q ); q = m3*q*2.07; 
	f += 0.00390625*noise( q ); q = m3*q*2.08;  
#endif
	return vec3(f);
}

float GetRoadFactor(vec2 pixel)
{
	float roadScale = 1.0;

	if (SHADER_HAS_SPLATMAP4 > 0.0)
	{// Also grab the roads map, if we have one...
		float road = texture(u_RoadsControlMap, pixel).r;

		if (road > GRASS_DISTANCE_FROM_ROADS)
		{
			roadScale = 0.0;
		}
		else if (road > 0.0)
		{
			roadScale = 1.0 - clamp(road / GRASS_DISTANCE_FROM_ROADS, 0.0, 1.0);
		}
		else
		{
			roadScale = 1.0;
		}
	}
	else
	{
		roadScale = 1.0;
	}

	return 1.0 - clamp(roadScale * 0.6 + 0.4, 0.0, 1.0);
}

float GetHeightmap(vec2 pixel)
{
	return texture(u_HeightMap, pixel).r;
}

vec2 GetMapTC(vec3 pos)
{
	vec2 mapSize = u_Maxs.xy - u_Mins.xy;
	return (pos.xy - u_Mins.xy) / mapSize;
}

vec3 OffsetForPosition(vec3 pos)
{
	vec3 fbm3D = noise/*fbm*/(pos * uRandomScale);
	vec2 pixel = GetMapTC(pos);
	float roadScaleZ = GetRoadFactor(pixel);
	float offsetScaleZ = fbm3D.z * clamp(1.0 - roadScaleZ, 0.75, 1.0);

	float offsetX = fbm3D.x;
	float offsetY = fbm3D.y;
	float offsetZ = max(offsetScaleZ, roadScaleZ);
	vec3 O = vec3(offsetX, offsetY, offsetZ) / (offsetX + offsetY + offsetZ);
	O.z = offsetZ;
	O -= 0.5;

	return O * uTessAlpha;
}
#endif //defined(USE_TESSELLATION_3D) && defined(USE_EDGE_TESSELLATION)

void main()
{
	vec3 position;
	vec3 normal;

#ifdef __HEIGHTMAP_TERRAIN_TEST__
	vec3 heightMap = vec3(0.0);

	if (USE_IS2D <= 0.0)
	{
		vec2 coord;
		coord = vec2(attr_Position.xy / u_Local9.r);
		vec4 hm = texture(u_HeightMap, coord);
		float hmt = length(hm);
		heightMap.z = hmt * u_Local9.g;
	}
#endif //__HEIGHTMAP_TERRAIN_TEST__

	position  = attr_Position;
	normal    = attr_Normal * 2.0 - 1.0;


#if defined(USE_TESSELLATION) && defined(USE_EDGE_TESSELLATION)
	vec3 baseVertPos = position;
	position.z += OffsetForPosition(position);
#endif //defined(USE_TESSELLATION) && defined(USE_EDGE_TESSELLATION)

#if defined(USE_TESSELLATION_3D) && defined(USE_EDGE_TESSELLATION)
	vec3 baseVertPos = position;
	position += OffsetForPosition(position);
#endif //defined(USE_TESSELLATION_3D) && defined(USE_EDGE_TESSELLATION)

#ifdef __HEIGHTMAP_TERRAIN_TEST__
	position.xyz += heightMap;
#endif //__HEIGHTMAP_TERRAIN_TEST__

	vec2 texCoords = attr_TexCoord0.st;

#if 0
	if (USE_DEFORM == 1.0)
	{
		position = DeformPosition(position, normal, attr_TexCoord0.st);
	}
#endif

	gl_Position = u_ModelViewProjectionMatrix * vec4(position, 1.0);

	vec3 preMMPos = position.xyz;

#if 0
	//if (USE_VERTEX_ANIM == 1.0 || USE_SKELETAL_ANIM == 1.0)
	{
		position = (u_ModelMatrix * vec4(position, 1.0)).xyz;
		normal = (u_ModelMatrix * vec4(normal, 0.0)).xyz;
	}

	if (USE_TC == 1.0)
	{
		texCoords = GenTexCoords(u_TCGen0, position, normal, u_TCGen0Vector0, u_TCGen0Vector1);
		texCoords = ModTexCoords(texCoords, position, u_DiffuseTexMatrix, u_DiffuseTexOffTurb);
	}
#endif


	if (!(u_textureScale.x <= 0.0 && u_textureScale.y <= 0.0) && !(u_textureScale.x == 1.0 && u_textureScale.y == 1.0))
	{
		texCoords *= u_textureScale;
	}

	var_Color = CalcColor(position, normal);

#if 0
	if (USE_FOG == 1.0)
	{
		var_Color *= vec4(1.0) - u_FogColorMask * sqrt(clamp(CalcFog(position), 0.0, 1.0));
	}
#endif

	var_TexCoords = texCoords;


	if (USE_LIGHTMAP > 0.0)
	{
		var_TexCoords2 = attr_TexCoord1.st;
	}
	else
	{
		var_TexCoords2 = vec2(0.0);
	}

	var_PrimaryLightDir.xyz = u_PrimaryLightOrigin.xyz - (position * u_PrimaryLightOrigin.w);
	var_ViewDir = u_ViewOrigin - position;
	var_Normal = normal.xyz;
	var_Slope = 0.0;
	var_GrassSlope = 0.0;

#if !defined(USE_TESSELLATION_3D)
	if (USE_REGIONS > 0.0 || USE_TRIPLANAR > 0.0)
	{
		//
		// Steep Maps...
		//

		float pitch = 0.0;

		if (SHADER_HAS_STEEPMAP > 0.0 || (GRASS_ENABLED > 0.0 && USE_TRIPLANAR > 0.0))
		{
			pitch = normalToSlope(normalize(normal.xyz));
		}
		
		var_GrassSlope = length(pitch);

		if (SHADER_HAS_STEEPMAP > 0.0)
		{// Steep maps...
			if (pitch > 46.0 && USE_REGIONS <= 0.0)
			{
				var_Slope = clamp(pow(clamp((pitch - 46.0) / 44.0, 0.0, 1.0), 0.75), 0.0, 1.0);
				
				if (USE_REGIONS > 0.0)
				{
					var_Slope = 0.0;
				}
				else
				{
					var_Slope = smoothstep(0.2, 0.7, var_Slope);
				}
			}
			else
			{
				if (USE_REGIONS > 0.0)
				{
					var_Slope = clamp(pow(clamp(pitch / 90.0, 0.0, 1.0), 2.0), 0.0, 1.0);
					var_Slope = smoothstep(0.5, 1.0, 1.0 - var_Slope);
				}
				else
				{
					var_Slope = 0.0;
				}
			}
		}
	}
#endif //!defined(USE_TESSELLATION_3D)

	var_Blending = vec3(0.0);

#if !defined(USE_TESSELLATION_3D)
	if (USE_REGIONS > 0.0 || USE_TRIPLANAR > 0.0)
	{
		GetBlending(normalize(attr_Normal.xyz * 2.0 - 1.0));
	}
#endif //!defined(USE_TESSELLATION_3D)

#if defined(USE_TESSELLATION) || defined(USE_TESSELLATION_3D)
#if defined(USE_EDGE_TESSELLATION)
	WorldPos_CS_in = vec4(baseVertPos.xyz, 1.0);
	gl_Position = vec4(position.xyz, 1.0);
#else //!defined(USE_EDGE_TESSELLATION)
	WorldPos_CS_in = vec4(position.xyz, 1.0);
	gl_Position = vec4(position.xyz, 1.0);
#endif //defined(USE_EDGE_TESSELLATION)
	TexCoord_CS_in = var_TexCoords.xy;
	Normal_CS_in = var_Normal.xyz;
	ViewDir_CS_in = var_ViewDir;
	Color_CS_in = var_Color;
	PrimaryLightDir_CS_in = var_PrimaryLightDir;
	TexCoord2_CS_in = var_TexCoords2;
	Blending_CS_in = var_Blending;
	envTC_CS_in = vec2(0.0);
	Slope_CS_in = var_Slope;
	GrassSlope_CS_in = var_GrassSlope;
#endif //defined(USE_TESSELLATION) || defined(USE_TESSELLATION_3D)

	var_vertPos = position.xyz;

}