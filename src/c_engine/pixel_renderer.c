/* ═══════════════════════════════════════════════════════════════
 *  C PIXEL RENDERER ENGINE (pixel_renderer.c)
 *  Động cơ vẽ Pixel Art 16-bit SNES chuẩn C thuần (Software Rasterizer)
 * ═══════════════════════════════════════════════════════════════ */
#include "pixel_renderer.h"

PixelBuffer* create_pixel_buffer(int width, int height) {
    PixelBuffer* buf = (PixelBuffer*)malloc(sizeof(PixelBuffer));
    if (!buf) return NULL;
    buf->width = width;
    buf->height = height;
    buf->pixels = (ColorRGBA*)calloc(width * height, sizeof(ColorRGBA));
    return buf;
}

void free_pixel_buffer(PixelBuffer* buf) {
    if (buf) {
        if (buf->pixels) free(buf->pixels);
        free(buf);
    }
}

void clear_pixel_buffer(PixelBuffer* buf, ColorRGBA color) {
    if (!buf || !buf->pixels) return;
    int total = buf->width * buf->height;
    for (int i = 0; i < total; ++i) {
        buf->pixels[i] = color;
    }
}

void draw_pixel(PixelBuffer* buf, int x, int y, ColorRGBA color) {
    if (!buf || x < 0 || x >= buf->width || y < 0 || y >= buf->height) return;
    buf->pixels[y * buf->width + x] = color;
}

void draw_rect_c(PixelBuffer* buf, int x, int y, int w, int h, ColorRGBA color) {
    for (int py = y; py < y + h; ++py) {
        for (int px = x; px < x + w; ++px) {
            draw_pixel(buf, px, py, color);
        }
    }
}

void render_hand_drawn_survivor_c(PixelBuffer* buf, int x, int y, ColorRGBA armor_col) {
    ColorRGBA visor = { 20, 230, 255, 255 };
    ColorRGBA shadow = { (uint8_t)(armor_col.r * 0.5), (uint8_t)(armor_col.g * 0.5), (uint8_t)(armor_col.b * 0.5), 255 };
    ColorRGBA boot = { 20, 20, 25, 255 };

    /* Head & Visor */
    draw_rect_c(buf, x + 12, y + 4, 16, 10, armor_col);
    draw_rect_c(buf, x + 14, y + 8, 12, 4, visor);

    /* Armor Body */
    draw_rect_c(buf, x + 8, y + 14, 24, 18, armor_col);
    draw_rect_c(buf, x + 10, y + 16, 20, 14, shadow);

    /* Legs & Boots */
    draw_rect_c(buf, x + 10, y + 32, 8, 12, boot);
    draw_rect_c(buf, x + 22, y + 32, 8, 12, boot);
}

void render_hand_drawn_monster_c(PixelBuffer* buf, int x, int y, ColorRGBA beast_col) {
    ColorRGBA eye = { 255, 40, 40, 255 };
    ColorRGBA claw = { 230, 230, 210, 255 };
    ColorRGBA shadow = { (uint8_t)(beast_col.r * 0.4), (uint8_t)(beast_col.g * 0.4), (uint8_t)(beast_col.b * 0.4), 255 };

    /* Body Circle Rasterization */
    for (int py = -16; py <= 16; ++py) {
        for (int px = -16; px <= 16; ++px) {
            if (px * px + py * py <= 256) {
                ColorRGBA c = (py > 0) ? shadow : beast_col;
                draw_pixel(buf, x + 20 + px, y + 20 + py, c);
            }
        }
    }

    /* Glowing Eyes */
    draw_rect_c(buf, x + 12, y + 12, 4, 4, eye);
    draw_rect_c(buf, x + 24, y + 12, 4, 4, eye);

    /* Claws */
    draw_rect_c(buf, x + 8, y + 34, 4, 6, claw);
    draw_rect_c(buf, x + 28, y + 34, 4, 6, claw);
}

void render_hand_drawn_mecha_c(PixelBuffer* buf, int x, int y, ColorRGBA mecha_col) {
    ColorRGBA metal = { 90, 100, 115, 255 };
    ColorRGBA reactor = { 50, 255, 120, 255 };

    /* Chassis Frame */
    draw_rect_c(buf, x + 6, y + 6, 28, 32, metal);
    draw_rect_c(buf, x + 10, y + 10, 20, 24, mecha_col);

    /* Glowing Reactor Core */
    draw_rect_c(buf, x + 16, y + 16, 8, 8, reactor);
}
