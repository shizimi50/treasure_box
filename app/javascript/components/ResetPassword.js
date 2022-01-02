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

export default function ResetPassword() {
  const classes = useStyles();
  const { register, handleSubmit, control, formState: { errors } } = useForm();
  const [loading, setLoading] = useState(false);

  const doSubmit = (data) => {
    if(!loading){ return }
    setLoading(true)
    console.log(data);
    setLoading(false)
  }

  const doError = () => {
    console.log(errors);
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
            Password reset
          </Typography>
          <form className={classes.form} autoComplete="off" onSubmit={handleSubmit(doSubmit,doError)}>
            <TextField
              variant="outlined"
              size="small"
              margin="normal"
              fullWidth
              id="email"
              label="Email"
              name="email"
              autoComplete="email"
              autoFocus
              {...register('email', { required: 'Emailを入力してください', pattern: { value: /^[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/i, message: 'Emailを正しく入力してください' }})}
              error={!!errors.email}
              helperText={!!errors.email ? errors.email.message : ''}
            />
            <ColorButton
              type="submit"
              fullWidth
              variant="contained"
              color="primary"
              className={classes.submit}
            >
              送信
            </ColorButton>
            <Grid container>
              <Grid item>
                <Link href="/login" color="inherit" variant="body2">
                  {"ログイン画面へ戻る"}
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
