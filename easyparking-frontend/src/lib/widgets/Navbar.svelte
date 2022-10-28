<script>
    import Link from '$lib/shared/ui/Link.svelte';
    import logo from '$lib/shared/assets/logo.svg';
    let menuActive = false;
    const links = [
        { page: '/nearby', name: 'nearby parkings' },
        { page: '/starred', name: 'starred' },
        { page: '/login', name: 'log in' },
    ];
    const toggleMenu = () => {
        menuActive = !menuActive;
    };
</script>

<header>
    <button
        class={menuActive ? 'burger active' : 'burger'}
        on:click={toggleMenu}
    />
    <div class="logo">
        <a href="/">
            <img src={logo} alt="logo" />
            <span>Easy Parking</span>
        </a>
    </div>
    <ul class={`links-list ${menuActive ? 'active' : 0}`}>
        {#each links as link (link.page)}
            <li>
                <Link to={link.page} text={link.name} size="l" />
            </li>
        {/each}
    </ul>
</header>

<style lang="scss">
  header {
    position: fixed;
    min-width: 100%;
    z-index: 999;
    height: var(--navbar-height-desktop);
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 150px;
    text-align: center;
    background: #4d4d6d;
    .burger {
      display: none;
    }
    .logo {
      a {
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 40px;
        line-height: 50px;
        font-weight: 800;
        text-decoration: none;
        color: var(--color-text);
        cursor: pointer;
      }
    }
    .links-list {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0;
      margin: 0;
      list-style: none;
    }
  }

  @media (max-width: 1091px) {
    header {
      padding: 0px 50px;
      .logo {
        a {
          font-size: 24px;
          line-height: 30px;
        }
      }
    }
  }
  @media (max-width: 768px) {
    header {
      padding: 0 20px;
      .logo {
        a {
          font-size: 24px;
          line-height: 30px;
        }
      }
      .links-list {
        flex: 0 1 55%;
      }
    }
  }
  @media (max-width: 600px) {
    header {
      flex-direction: column;
      justify-content: flex-start;
      height: 60px;
      padding: 0;

      .burger {
        display: block;
        width: 100%;
        min-height: 100%;
        background: #4d4d6d;
        outline: none;
        border: none;
        color: var(--color-text);
        font-size: 30px;
        line-height: 38px;
        font-weight: 600;
        &::before {
          content: '';
          position: absolute;
          height: 4px;
          width: 40px;
          transform: translate(-90%) rotate(45deg);
          background-color: #a09ef0;
          transition: all 0.5s;
        }
        &::after {
          content: '';
          position: absolute;
          height: 4px;
          width: 40px;
          transform: translate(-25%) rotate(-45deg);
          background-color: #a09ef0;
          transition: all 0.5s;
        }
        &.active::before {
          transform: translate(-90%) rotate(-45deg);
        }
        &.active::after {
          transform: translate(-25%) rotate(45deg);
        }
      }
      .logo {
        a {
          display: none;
        }
      }
      .links-list {
        opacity: 0;
        pointer-events: none;
        border-top: 2px solid #a09ef0;
        position: relative;
        padding-bottom: 20px;
        top: 0;
        width: 100vw;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;
        background: rgba(77, 77, 109, 0.9);
        transition: opacity 0.2s;
        li {
          transform: scale(0.5);
          transition: transform 0.5s;
          margin-top: 20px;
        }
        &.active {
          opacity: 1;
          pointer-events: all;
          li {
            transform: scale(1);
          }
        }
      }
    }
  }
</style>
