import React, { useState } from 'react';
import Avatar from '@material-ui/core/Avatar';
import Button from '@material-ui/core/Button';
import CssBaseline from '@material-ui/core/CssBaseline';
import TextField from '@material-ui/core/TextField';
import Link from '@material-ui/core/Link';
import Grid from '@material-ui/core/Grid';
import Box from '@material-ui/core/Box';
import Typography from '@material-ui/core/Typography';
import { makeStyles, withStyles } from '@material-ui/core/styles';
import { ThemeProvider } from '@material-ui/core/styles';
import Container from '@material-ui/core/Container';
import { grey } from '@material-ui/core/colors';
import theme from './theme';
import Copyright from './Copyright';
import { useForm } from "react-hook-form";
import axios from "axios";

const useStyles = makeStyles((theme) => ({
  paper: {
    marginTop: theme.spacing(8),
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
  },
  avatar: {
    margin: theme.spacing(1),
    backgroundColor: theme.palette.secondary.main,
  },
  form: {
    width: '100%', // Fix IE 11 issue.
    marginTop: theme.spacing(1),
  },
  submit: {
    margin: theme.spacing(3, 0, 2),
  },
}));

const ColorButton = withStyles((theme) => ({
  root: {
    color: theme.palette.getContrastText(grey[900]),
    backgroundColor: grey[900],
      '&:hover': {
      backgroundColor: grey[700],
    },
  },
}))(Button);

export default function Login() {
  const classes = useStyles();
  const { register, handleSubmit, control, formState: { errors } } = useForm();
  const [loading, setLoading] = useState(false);
  const config = {
    headers: {
      'X-Requested-With': 'XMLHttpRequest'
    }
  };

  const doSubmit = (data) => {
    if(loading){ return }
    setLoading(true);
    axios.post('/api/v1/users/login', data, config)
      .then(res => {
        console.log(res.data);
        setLoading(false);
        checkLogin();
      })
      .catch(error => {
        console.log(error);
      });
  }

  const doError = () => {
    console.log(errors);
  }

  const checkLogin = () =>{
    axios.get('/api/v1/users/current_user', config)
      .then(res => {
        console.log(res);
        console.log(res.data);
      })
      .catch(error => {
        console.log(error);
      });
  }

  return (
    <ThemeProvider theme={theme}>
      <Container component="main" maxWidth="xs">
        <CssBaseline />
        <div className={classes.paper}>
          {/*<Avatar className={classes.avatar}>
            <LockOutlinedIcon />
          </Avatar>*/}
          <Typography component="h1" variant="h5">
            Log in
          </Typography>
          <form className={classes.form} onSubmit={handleSubmit(doSubmit,doError)}>
            <TextField
              variant="outlined"
              size="small"
              margin="normal"
              fullWidth
              id="email"
              label="Email"
              name="email"
              autoComplete="email"
              {...register('email', { required: 'Emailを入力してください', pattern: { value: /^[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/i, message: 'Emailを正しく入力してください' }})}
              error={!!errors.email}
              helperText={!!errors.email ? errors.email.message : ''}
            />
            <TextField
              variant="outlined"
              size="small"
              margin="normal"
              fullWidth
              name="password"
              label="Password"
              type="password"
              id="password"
              autoComplete="current-password"
              {...register('password', { required: 'Passwordを入力してください' })}
              error={!!errors.password}
              helperText={!!errors.password ? errors.password.message : ''}
            />
            <ColorButton
              type="submit"
              fullWidth
              variant="contained"
              color="primary"
              className={classes.submit}
            >
              ログイン
            </ColorButton>
            <Grid container>
              <Grid item xs>
                <Link href="/resetpassword" color="inherit" variant="body2">
                  Forgot password?
                </Link>
              </Grid>
              <Grid item>
                <Link href="/signup" color="inherit" variant="body2">
                  {"Sign Up"}
                </Link>
              </Grid>
            </Grid>
          </form>
        </div>
        <Box mt={8}>
          <Copyright />
        </Box>
      </Container>
    </ThemeProvider>
  );
}