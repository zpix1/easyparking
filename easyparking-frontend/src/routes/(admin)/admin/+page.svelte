<script>
  import Button from "$lib/shared/ui/Button.svelte";
  import { adminAuth } from "./store";

  const fileds = { password: "" };
  let adminError = "";
  const submitHandler = () => {
    
  };
</script>

<svelte:head>
  <title>Admin</title>
</svelte:head>

<section class="container">
  <h1>Please log in to get into admin console</h1>
  <form on:submit|preventDefault={submitHandler}>
    <div class="form-field">
      <label for="password">PASSWORD</label>
      <input type="password" id="password" bind:value={fileds.password} />
    </div>
    <div class="error">{adminError}</div>
    <Button type="submit">login</Button>
  </form>
</section>

<style lang="scss">
  .container {
    width: 50%;
    padding: 0px 10px 50px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  h1 {
    text-align: center;
    font-size: 64px;
    line-height: 80px;
  }
  form {
    min-width: 70%;
    margin: 0 auto;
    text-align: center;
    margin-bottom: 30px;
    .form-field {
      margin: 22px auto;
      text-align: left;
    }
    input {
      width: 100%;
      border-radius: 10px;
      height: 56px;
      margin-top: 20px;
      background: rgba(217, 217, 217, 0.7);
      font: var(--font-l);
      font-weight: 900;
      transition: all 0.5s;
      &:focus {
        outline: 3px solid var(--primary-color);
        filter: drop-shadow(2px 2px 5px #a09ef0)
          drop-shadow(-2px -2px 5px #831dd6);
      }
    }
    label {
      font: var(--font-m);
      font-weight: 600;
    }
    .error {
      text-align: center;
      font: var(--font-m);
      color: rgb(237, 110, 110);
    }
  }
  @media (max-width: 1091px) {
  }
  @media (max-width: 768px) {
    .container {
      width: 80%;
      padding: 0px 0px 50px;
    }
    h1 {
      font-size: 40px;
      line-height: 50px;
    }
    form {
      min-width: 100%;
      input {
        width: 100%;
        font: var(--font-m);
        font-weight: 900;
        transition: all 0.5s;
        &:focus {
          outline: 3px solid var(--primary-color);
          filter: drop-shadow(2px 2px 5px #a09ef0)
            drop-shadow(-2px -2px 5px #831dd6);
        }
      }
    }
  }

  @media (max-width: 426px) {
    h1 {
      font-size: 30px;
      line-height: 38px;
    }
  }
</style>
