<script>
    export let text = 'default';
</script>

<button>{text}</button>

<style>
    button {
        padding: 26px 80px;
        border: 5px solid #a09ef0;
        background: #2b2a53;
        border-radius: 51px;
        font-weight: 600;
        font: var(--font-l);
        color: var(--color-text);
        text-align: center;
        text-transform: uppercase;
        cursor: pointer;
        transition: 0.3s ease;
    }
    button:hover {
        background: rgba(160, 158, 240, 0.7);
        filter: drop-shadow(5px 5px 20px #a09ef0)
            drop-shadow(-5px -5px 10px #831dd6);
    }
</style>
