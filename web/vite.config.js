import {defineConfig} from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
    base: "./",
    plugins: [vue()],
    server: {
        proxy: {
            '/api': {
                target: 'http://127.0.0.1:8787/',
                changeOrigin: true,
            }
        }
    }
})
