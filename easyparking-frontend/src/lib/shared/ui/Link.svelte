<script>
    export let text = 'default';
    export let to = '/';
    export let size = 'm';
    export let external = false;
</script>

<a
    class={size === 'l' ? 'size-l' : 'size-m'}
    href={to}
    target={external ? '_blanck' : ''}>{text}</a
>

<style lang="scss">
    a {
        position: relative;
        margin-left: 50px;
        text-decoration: none;
        color: var(--color-text);
        cursor: pointer;
        &.size-m {
            font: var(--font-m);
        }
        &.size-l {
            font: var(--font-l);
        }
        &:hover {
            color: #a09ef0;
        }
        &:after {
            content: '';
            display: block;
            position: absolute;
            right: 0;
            bottom: -3px;
            width: 0;
            height: 2px;
            background-color: #a09ef0;
            transition: width 0.3s;
        }
        &:hover:after {
            content: '';
            width: 100%;
            display: block;
            position: absolute;
            left: 0;
            bottom: -3px;
            height: 2px;
            background-color: #a09ef0;
            transition: width 0.3s;
        }
    }
    @media (max-width: 768px) {
        a {
            margin-left: 14px;
            &.size-l {
                font-size: 16px;
                line-height: 30px;
                font-weight: 400;
            }
        }
    }
</style>
