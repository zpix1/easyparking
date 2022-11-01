import adapter from '@sveltejs/adapter-auto';
import scssPreprocess from 'svelte-preprocess';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	preprocess: scssPreprocess({
		sass: true
	}),
	kit: {
		adapter: adapter()
	}
};

export default config;
