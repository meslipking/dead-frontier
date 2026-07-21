/* ═══════════════════════════════════════════════════════════════
 *  C PIXEL RENDERER ENGINE (pixel_renderer.h)
 *  Động cơ vẽ Pixel Art 16-bit SNES chuẩn C thuần (Software Rasterizer)
 * ═══════════════════════════════════════════════════════════════ */
#ifndef PIXEL_RENDERER_H
#define PIXEL_RENDERER_H

#include <stdint.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    uint8_t r;
    uint8_t g;
    uint8_t b;
    uint8_t a;
} ColorRGBA;

typedef struct {
    int width;
    int height;
    ColorRGBA* pixels;
} PixelBuffer;

/* Engine API */
PixelBuffer* create_pixel_buffer(int width, int height);
void free_pixel_buffer(PixelBuffer* buf);
void clear_pixel_buffer(PixelBuffer* buf, ColorRGBA color);
void draw_pixel(PixelBuffer* buf, int x, int y, ColorRGBA color);
void draw_rect_c(PixelBuffer* buf, int x, int y, int w, int h, ColorRGBA color);
void draw_sprite16_c(PixelBuffer* buf, int start_x, int start_y, const uint8_t* sprite_matrix, int sw, int sh, ColorRGBA primary_col, ColorRGBA shadow_col);
void render_hand_drawn_survivor_c(PixelBuffer* buf, int x, int y, ColorRGBA armor_col);
void render_hand_drawn_monster_c(PixelBuffer* buf, int x, int y, ColorRGBA beast_col);
void render_hand_drawn_mecha_c(PixelBuffer* buf, int x, int y, ColorRGBA mecha_col);

#endif /* PIXEL_RENDERER_H */
